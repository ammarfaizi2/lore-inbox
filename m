Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268700AbUILMq0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268700AbUILMq0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 08:46:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268704AbUILMq0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 08:46:26 -0400
Received: from jdi.jdimedia.nl ([212.204.192.51]:42706 "EHLO jdi.jdimedia.nl")
	by vger.kernel.org with ESMTP id S268700AbUILMqQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 08:46:16 -0400
Date: Sun, 12 Sep 2004 14:46:08 +0200 (CEST)
From: Igmar Palsenberg <maillist@jdimedia.nl>
To: Wolfpaw - Dale Corse <admin-lists@wolfpaw.net>
cc: linux-kernel@vger.kernel.org, grsecurity@grsecurity.net,
       bugtraq@securityfocus.com
Subject: Re: [grsec] Linux 2.4.27 SECURITY BUG - TCP Local (probable Remote)
 Denial of Service
In-Reply-To: <004c01c49848$2608e180$0200a8c0@wolf>
Message-ID: <Pine.LNX.4.58.0409121442130.12903@jdi.jdimedia.nl>
References: <004c01c49848$2608e180$0200a8c0@wolf>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>  My apologies if this is to the wrong place - it happens to be the
> first kernel bug I have found (or what appears to be one), and I'm
> not entirely sure how to properly inform the Linux community about
> it. 

It's usually best to use the names / addressen in the MAINTAINERS file. 
Security issues like this are IMHO best first adressed to the maintainer 
of the code that is most likely to contain the bug.

I would suggest sending this to Dave Miller or Alexey Kuznetsov, both 
names which appear frequently when it comes to IP related stuff.


Regards,


	Igmar
