Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271828AbTGRQWe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 12:22:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268548AbTGRQVj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 12:21:39 -0400
Received: from lindsey.linux-systeme.com ([80.190.48.67]:266 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S271785AbTGRQUE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 12:20:04 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Stephane Wirtel <stephane.wirtel@belgacom.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ide-scsi in 2.6.0 ?
Date: Fri, 18 Jul 2003 18:34:39 +0200
User-Agent: KMail/1.5.2
References: <20030718162156.GA2946@gentoo>
In-Reply-To: <20030718162156.GA2946@gentoo>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307181834.39951.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 18 July 2003 18:21, Stephane Wirtel wrote:

Hi Stephane,

> I have a problem with ide-scsi
> i put ide-scsi=/dev/hdc  in the "append"  of my grub configuration.
where do you read such bad information?

> but, with dmesg, i can see, that i have a problem with this argument,
> because the kernel tells me, than it's a bad option.
> my error : ide_setup: ide-scsi=/dev/hdc -- BAD OPTION
> A solution ?
yes. "hdc=ide-scsi

ciao, Marc

