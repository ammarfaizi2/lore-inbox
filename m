Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269021AbTBWXer>; Sun, 23 Feb 2003 18:34:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269024AbTBWXer>; Sun, 23 Feb 2003 18:34:47 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:8929 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S269021AbTBWXeq>;
	Sun, 23 Feb 2003 18:34:46 -0500
Date: Sun, 23 Feb 2003 15:45:17 -0800
From: Mike Anderson <andmike@us.ibm.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Patrick Mochel <mochel@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Bug with (maybe not *in*) sysfs
Message-ID: <20030223234517.GA3158@beaverton.ibm.com>
Mail-Followup-To: "Martin J. Bligh" <mbligh@aracnet.com>,
	Patrick Mochel <mochel@osdl.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <5480000.1046028715@[10.10.2.4]> <Pine.LNX.4.33.0302231310500.923-100000@localhost.localdomain> <20030223202401.GA1452@beaverton.ibm.com> <12070000.1046032398@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12070000.1046032398@[10.10.2.4]>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.0.32 on an i486
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh [mbligh@aracnet.com] wrote:
> OK, so two similar, but not identical cards using the same driver?
> First patch mentioned looks very simple, but won't apply to 2.5.62

Are you seeing this problem on 2.5.62? The registration problem I
described should be gone in 2.5.62.

-andmike
--
Michael Anderson
andmike@us.ibm.com

