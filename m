Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263922AbTLXWx3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Dec 2003 17:53:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263953AbTLXWx3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Dec 2003 17:53:29 -0500
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:55954 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP id S263922AbTLXWx2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Dec 2003 17:53:28 -0500
Date: Wed, 24 Dec 2003 14:11:14 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Bruce Ferrell <bferrell@baywinds.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: is it possible to have a kernel module with a BSD license?!
Message-ID: <20031224221114.GB6438@matchmail.com>
Mail-Followup-To: Arjan van de Ven <arjanv@redhat.com>,
	Bruce Ferrell <bferrell@baywinds.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <3FE9ADEE.1080103@baywinds.org> <1072282214.5267.0.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1072282214.5267.0.camel@laptop.fenrus.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 24, 2003 at 05:10:14PM +0100, Arjan van de Ven wrote:
> On Wed, 2003-12-24 at 16:17, Bruce Ferrell wrote:
> > from the project announcement on freshmeat:
> > 
> > 
> >   Dazuko 2.0.0-pre5 (Default)
> >   by John Ogness - Tuesday, November 11th 2003 06:56 PST
> > 
> > About:
> > This project provides a kernel module which provides 3rd-party 
> > applications with an interface for file access control. It was 
> > originally developed for on-access virus scanning. Other uses include a 
> > file-access monitor/logger or external security implementations. It 
> > operates by intercepting file-access calls and passing the file 
> > information to a 3rd-party application. The 3rd-party application the
> 
> I think you need to look further; the linux kernel portion sure is GPL
> ...

Then the wrapper can be GPL then and the rest BSD?
