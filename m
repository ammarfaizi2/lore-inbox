Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268122AbUHTOsc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268122AbUHTOsc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 10:48:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268134AbUHTOsc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 10:48:32 -0400
Received: from the-village.bc.nu ([81.2.110.252]:63623 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268122AbUHTOs3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 10:48:29 -0400
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kernel@wildsau.enemy.org, fsteiner-mail@bio.ifi.lmu.de,
       diablod3@gmail.com
In-Reply-To: <41260675.nail8LDG1UIJL@burner>
References: <200408041233.i74CX93f009939@wildsau.enemy.org>
	 <d577e5690408190004368536e9@mail.gmail.com> <4124A024.nail7X62HZNBB@burner>
	 <4124BA10.6060602@bio.ifi.lmu.de>
	 <1092925942.28353.5.camel@localhost.localdomain>
	 <4125E5B9.nail8LD2EG3NM@burner>
	 <1093001143.30940.23.camel@localhost.localdomain>
	 <41260675.nail8LDG1UIJL@burner>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1093009555.30941.48.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 20 Aug 2004 14:46:08 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-08-20 at 15:11, Joerg Schilling wrote:
> Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> 
> > > On a decently administrated Linux system, only root is able to send SCSI 
> > > commands because only root is able to open the apropriate /dev/* entries.
> >
> > Wrong (as usual)
> 
> Useless as usual :-(

Unlike you I spend some of my time looking at large real world Linux
installations.

*Plonk*
