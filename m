Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271854AbTGRQ0l (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 12:26:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271851AbTGRQ0c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 12:26:32 -0400
Received: from tomts8.bellnexxia.net ([209.226.175.52]:10690 "EHLO
	tomts8-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S271849AbTGRQ0D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 12:26:03 -0400
Date: Fri, 18 Jul 2003 12:39:46 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Stephane Wirtel <stephane.wirtel@belgacom.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ide-scsi in 2.6.0 ?
In-Reply-To: <20030718162156.GA2946@gentoo>
Message-ID: <Pine.LNX.4.53.0307181238540.5655@localhost.localdomain>
References: <20030718162156.GA2946@gentoo>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jul 2003, Stephane Wirtel wrote:

> Hi 
> 
> I have a problem with ide-scsi
> 
> i put ide-scsi=/dev/hdc  in the "append"  of my grub configuration.

i'm pretty sure that should say "hdc=ide-scsi".

rday
