Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132485AbRCaT5T>; Sat, 31 Mar 2001 14:57:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132488AbRCaT5K>; Sat, 31 Mar 2001 14:57:10 -0500
Received: from [12.37.36.130] ([12.37.36.130]:29454 "HELO
	util.interactivefunds.com") by vger.kernel.org with SMTP
	id <S132485AbRCaT4u>; Sat, 31 Mar 2001 14:56:50 -0500
Date: Sat, 31 Mar 2001 13:55:23 -0600
To: linux-kernel@vger.kernel.org
Subject: ipx wont compile in 2.4.3
Message-ID: <20010331135523.A4426@undertow>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
From: Stephen Crowley <stephenc@iexchange.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trying to compile 2.4.3 with ipx support gives the following

net/network.o(.data+0x3e48): undefined reference to sysctl_ipx_pprop_broadcasting'


--Stephen
