Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263564AbTK1XlS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Nov 2003 18:41:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263568AbTK1XlS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Nov 2003 18:41:18 -0500
Received: from chaos.sr.unh.edu ([132.177.249.105]:1952 "EHLO chaos.sr.unh.edu")
	by vger.kernel.org with ESMTP id S263564AbTK1XlR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Nov 2003 18:41:17 -0500
Date: Fri, 28 Nov 2003 18:40:32 -0500 (EST)
From: Kai Germaschewski <kai.germaschewski@unh.edu>
X-X-Sender: kai@chaos.sr.unh.edu
To: Valdis.Kletnieks@vt.edu
cc: Tonnerre Anklin <thunder@keepsake.ch>,
       Werner Cornelius <werner@isdn4linux.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [I4L] hfcpci missing MODULE_LICENSE 
In-Reply-To: <200311280322.hAS3M602016305@turing-police.cc.vt.edu>
Message-ID: <Pine.LNX.4.44.0311281838330.22654-100000@chaos.sr.unh.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Nov 2003 Valdis.Kletnieks@vt.edu wrote:

> which says: "I guess the license is meant to be GPL."  And so it was almost
> certainly intended to be.
> 
> > +MODULE_LICENSE("GPL");
> >  MODULE_AUTHOR("Kai Germaschewski <kai.germaschewski@gmx.de>/Werner Cornelius <werner@isdn4linux.de>");
> 
> 
> Unfortunately, neither you nor I nor anybody but Kai or Werner (or their
> assignees) can do this, as I understand the law.  The only proper resolutions
> here are to get one of them to make some sort of statement (I suspect even a
> "Yea, it's GPL, we just forgot the macro" e-mail from one of them would be good
> enough), or to pull the code out of the 2.6.0 tree till it *is* resolved.

Yes, it's GPL, it actually even says so in the comment at the beginning of 
the file. It's based on Werner's original driver which was GPL, and the 
work I contributed to the Linux kernel is GPL too, of course.

--Kai


