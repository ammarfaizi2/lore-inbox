Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268448AbUHYUJT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268448AbUHYUJT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 16:09:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268465AbUHYUIf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 16:08:35 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:62737 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S268448AbUHYUGy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 16:06:54 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Greg KH <greg@kroah.com>
Subject: Re: devfs -> udev transition: vcsN are not created
Date: Wed, 25 Aug 2004 23:06:22 +0300
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <200408251517.31608.vda@port.imtp.ilyichevsk.odessa.ua> <20040825194308.GC9706@kroah.com>
In-Reply-To: <20040825194308.GC9706@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408252306.22741.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 25 August 2004 22:43, Greg KH wrote:
> On Wed, Aug 25, 2004 at 03:17:31PM +0300, Denis Vlasenko wrote:
> > I am migrating my 2.6 systems from devfs to udev.
> > Versions:
> >
> > # uname -a
> > Linux firebird 2.6.7-bk20 #6 Mon Jul 12 01:23:31 EEST 2004 i686 unknown
>
> Can you try the latest -mm tree?  It should have this fixed.  I'll be
> sending the patch that does this off to Linus later today.

Hopefully tomorrow.
--
vda

