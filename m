Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318470AbSHPPWv>; Fri, 16 Aug 2002 11:22:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318472AbSHPPWv>; Fri, 16 Aug 2002 11:22:51 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:60935 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S318470AbSHPPWu>; Fri, 16 Aug 2002 11:22:50 -0400
Date: Fri, 16 Aug 2002 17:26:41 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Jean-Luc Coulon <jean-luc.coulon@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20-pre2-ac3 stops responding
Message-ID: <20020816152641.GE11155@louise.pinerecords.com>
References: <3D5CFE83.136D81FC@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D5CFE83.136D81FC@wanadoo.fr>
User-Agent: Mutt/1.4i
X-OS: GNU/Linux 2.4.19-pre10/sparc SMP
X-Uptime: 72 days, 11:56
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> with 2.4.20-pre2 : 30s
> with 2.4.30-pre2-ac3 : 55s

Do you get DMA on your IDE disks at all?

hdparm -iv /dev/hdX

T.
