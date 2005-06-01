Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261436AbVFAP7H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261436AbVFAP7H (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 11:59:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261447AbVFAP6v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 11:58:51 -0400
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:32239 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S261445AbVFAPzG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 11:55:06 -0400
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Wed, 01 Jun 2005 17:53:43 +0200
To: toon@hout.vanvergehaald.nl, schilling@fokus.fraunhofer.de,
       mrmacman_g4@mac.com, ltd@cisco.com, linux-kernel@vger.kernel.org,
       dtor_core@ameritech.net, 7eggert@gmx.de
Subject: Re: OT] Joerg Schilling flames Linux on his Blog
Message-ID: <429DDA07.nail7BFA4XEC5@burner>
References: <26A66BC731DAB741837AF6B2E29C10171E60DE@xmb-hkg-413.apac.cisco.com>
 <20050530093420.GB15347@hout.vanvergehaald.nl>
 <429B0683.nail5764GYTVC@burner>
 <46BE0C64-1246-4259-914B-379071712F01@mac.com>
 <429C4483.nail5X0215WJQ@burner> <20050531172204.GD17338@voodoo>
 <d120d500050531122879868bae@mail.gmail.com>
In-Reply-To: <d120d500050531122879868bae@mail.gmail.com>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

> Yes it could but why should it? The purpose of udev is to maintain
> dynamic /dev. Do you want to have thoustands quirks in udev to cope
> with bazillion configuration files for utilities whose authors refuse
> to adopt standard naming convention [for the operating system in
> question].

You show exactly the habbit that makes me unwiling to believe it makes
sense to put effort into anything in Linux that is not at least 5 years old.

10 Years ago, Linux was completely unsuable with Linux /dev/sg* naming 
and mapping conventions. After I did develop an abstraction layer that
made Linux usable people could use stable dev= parameters across
reboots of Linux.

Then somebody started to implement a way to make linux more sane with /dev/
but this method has been replaced before it did become ordinary.

Think again what you like to tell me here.... You like to tell me
cdrecord is one of thousands of bad programs but it is the first
program that introduced stability at command line level if talking about
generic SCSI usage. 

If somebody later develops something like udev (did not see it yet)
I would asume that this person would look at earlyer stable software and
provide some way of integration.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  
       schilling@fokus.fraunhofer.de	(work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
