Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264000AbTDWLhK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 07:37:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264002AbTDWLhK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 07:37:10 -0400
Received: from mxout3.netvision.net.il ([194.90.9.24]:3003 "EHLO
	mxout3.netvision.net.il") by vger.kernel.org with ESMTP
	id S264000AbTDWLhJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 07:37:09 -0400
Date: Wed, 23 Apr 2003 14:58:21 +0200
From: Nir Livni <nir_l3@netvision.net.il>
Subject: Re: FileSystem Filter Driver
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <000601c30998$4ab21690$4ee1db3e@pinguin>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
X-Mailer: Microsoft Outlook Express 5.00.2919.6700
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
X-Priority: 3
X-MSMail-priority: Normal
References: <000501c30983$1ffb8950$ade1db3e@pinguin>
 <1051092516.1896.7.camel@abhilinux.cygnet.co.in>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




> On Wed, 2003-04-23 at 15:58, Nir Livni wrote:
> > Hi all,
> > I am looking for information about writing a FileSystem Filter Driver on
RH.
> > Any documentation or source code samples whould be appreciated.
> >
>
> What's a FileSystem Filter Driver?
>
A FileSystem Filter Driver, is a driver the is located above the file system
driver, and filters calls. It may pass the call to the filesystem as is,
maybe change it, or fail it ("access denied" for example).
It is actually something that exists on Windows file systems, but I'm sure
it can also be done on Linux.


