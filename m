Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265581AbUAJVy6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 16:54:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265604AbUAJVy6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 16:54:58 -0500
Received: from netline-mail1.netline.ch ([195.141.226.27]:50447 "EHLO
	netline-mail1.netline.ch") by vger.kernel.org with ESMTP
	id S265581AbUAJVy5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 16:54:57 -0500
Subject: Re: [Dri-devel] 2.6 kernel change in nopage
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: dri-devel <dri-devel@lists.sourceforge.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0401011205110.2065@home.osdl.org>
References: <20031231182148.26486.qmail@web14918.mail.yahoo.com>
	 <1072958618.1603.236.camel@thor.asgaard.local>
	 <1072959055.5717.1.camel@laptop.fenrus.com>
	 <1072959820.1600.252.camel@thor.asgaard.local>
	 <20040101122851.GA13671@devserv.devel.redhat.com>
	 <1072967278.1603.270.camel@thor.asgaard.local>
	 <Pine.LNX.4.58.0401011205110.2065@home.osdl.org>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1073771694.2290.17.camel@thor.asgaard.local>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 10 Jan 2004 22:54:54 +0100
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


First of all, thanks for all the suggestions I've received in this
thread.

New patch up at http://penguinppc.org/~daenzer/DRI/drm-nopage.diff; does
this look acceptable to those who are going to do merges between the
trees? :)


-- 
Earthling Michel Dänzer      |     Debian (powerpc), X and DRI developer
Software libre enthusiast    |   http://svcs.affero.net/rm.php?r=daenzer

