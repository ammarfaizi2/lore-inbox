Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264433AbTLBXOf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 18:14:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264437AbTLBXOe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 18:14:34 -0500
Received: from 213-0-194-170.dialup.nuria.telefonica-data.net ([213.0.194.170]:1672
	"EHLO dardhal.mired.net") by vger.kernel.org with ESMTP
	id S264433AbTLBXOB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 18:14:01 -0500
Date: Wed, 3 Dec 2003 00:13:59 +0100
From: Jose Luis Domingo Lopez <linux-kernel@24x7linux.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4 future
Message-ID: <20031202231359.GA7056@localhost>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0312011212090.13692-100000@logos.cnet> <200312011226.04750.nbensa@gmx.net> <20031202115436.GA10288@physik.tu-cottbus.de> <20031202120315.GK13388@conectiva.com.br> <Pine.LNX.4.58.0312021402360.17892@moje.vabo.cz> <20031202131512.GU13388@conectiva.com.br> <Pine.LNX.4.58.0312021433360.8417@moje.vabo.cz> <20031202135423.GB13388@conectiva.com.br> <Pine.LNX.4.58.0312021508470.21855@moje.vabo.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0312021508470.21855@moje.vabo.cz>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 02 December 2003, at 15:21:54 -0500,
Tomas Konir wrote:

> 2.6 is still unstable now. I'm using -test10 on my workstation, but it 
> takes minimally an half year to use it on server. I can't use ext3 on 
> server, because of missing features such as ACL, dump (with acl's), 
> built in qouta and for last much different speed on SMP machine.
> 
If you can live with filesystem-level backups tar-like, maybe you should
have a look at "star", a tar implementation that is said to be capable
of archiving (and hopefully restoring :-) ACL.

Greetings.

-- 
Jose Luis Domingo Lopez
Linux Registered User #189436     Debian Linux Sid (Linux 2.6.0-test10-mm1)
