Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274095AbRISPwA>; Wed, 19 Sep 2001 11:52:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274096AbRISPvu>; Wed, 19 Sep 2001 11:51:50 -0400
Received: from prfdec.natur.cuni.cz ([195.113.56.1]:64782 "EHLO
	prfdec.natur.cuni.cz") by vger.kernel.org with ESMTP
	id <S274095AbRISPvk> convert rfc822-to-8bit; Wed, 19 Sep 2001 11:51:40 -0400
X-Envelope-From: mmokrejs
Posted-Date: Wed, 19 Sep 2001 17:51:27 +0200 (MET DST)
Date: Wed, 19 Sep 2001 17:51:27 +0200 (MET DST)
From: =?iso-8859-2?Q?Martin_MOKREJ=A9?= <mmokrejs@natur.cuni.cz>
To: Rik van Riel <riel@conectiva.com.br>
cc: linux-kernel@vger.kernel.org
Subject: Re: __alloc_pages: 0-order allocation failed still in -pre12
In-Reply-To: <Pine.LNX.4.33L.0109191215180.4279-100000@imladris.rielhome.conectiva>
Message-ID: <Pine.OSF.4.21.0109191749040.12658-100000@prfdec.natur.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Sep 2001, Rik van Riel wrote:

> On Wed, 19 Sep 2001, [iso-8859-2] Martin MOKREJ© wrote:
> 
> >   I tried 2.4.10-pre12
> 
> > I have to say I've been using for a week without any "0-order allocation
> > failed" patch from Marcelo. Now I see am back to the old stage. ;(
> 
> Impossible, the VM code which is in 2.4.10-pre11 and newer
> wasn't published until sunday night, so you can't have been
> using it for a week already. ;)

Sorry, again: I'm currently using plain 2.4.9 patched with -pre12.
I get the allocation errors. I got the image from kernel.dk/testing/ today
morning, as someone posted this address on the list.

My previous kernel is plain 2.4.9 patched with Marcelo's patched and in a
week period I did not receive nay single error message like that.

-- 
Martin Mokrejs - PGP5.0i key is at http://www.natur.cuni.cz/~mmokrejs
MIPS / Institute for Bioinformatics <http://mips.gsf.de>
GSF - National Research Center for Environment and Health
Ingolstaedter Landstrasse 1, D-85764 Neuherberg, Germany

