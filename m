Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263378AbTLALVP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 06:21:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263435AbTLALVP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 06:21:15 -0500
Received: from ookhoi.xs4all.nl ([213.84.114.66]:11205 "EHLO
	favonius.humilis.net") by vger.kernel.org with ESMTP
	id S263378AbTLALVO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 06:21:14 -0500
Date: Mon, 1 Dec 2003 12:21:12 +0100
From: Ookhoi <ookhoi@humilis.net>
To: Daniel Flinkmann <DFlinkmann@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0test11 overwriting file on mounted smb volume causes corrupted files!
Message-ID: <20031201112112.GA22180@favonius>
Reply-To: ookhoi@humilis.net
References: <200311290156.02239.DFlinkmann@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200311290156.02239.DFlinkmann@gmx.de>
X-Uptime: 17:58:39 up 15 days,  9:22, 25 users,  load average: 1.02, 1.01, 1.00
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

Daniel Flinkmann wrote (ao):
> [Please CC to me directly, I'm not on the linix kernel mailing list]
> 
> [1.] One line summary of the problem:
> 
> 2.6.0test11 overwriting file on mounted smb volume causes corrupted files! 

I saw te same with -test9 with cifs.
For some reason the November archive of
http://lists.samba.org/archive/samba-technical/ is gone, but google has
my report cached. Search for:

"problem with updating files on cifs mount"

I'm still stuck btw.
