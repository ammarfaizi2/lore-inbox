Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751550AbWJACdR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751550AbWJACdR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 22:33:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751552AbWJACdR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 22:33:17 -0400
Received: from smtp.osdl.org ([65.172.181.4]:64727 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751534AbWJACdP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 22:33:15 -0400
Date: Sat, 30 Sep 2006 19:32:53 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Eric Rannaud <eric.rannaud@gmail.com>
cc: Jeff Garzik <jeff@garzik.org>, v4l-dvb-maintainer@linuxtv.org,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, alan@lxorguk.ukuu.org.uk
Subject: Re: zoran driver breaks 'make all{yes,mod}config'
In-Reply-To: <5f3c152b0609301841h220b94e4wdbf000a729f8992c@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0609301931510.3952@g5.osdl.org>
References: <451F1887.3040102@garzik.org> <5f3c152b0609301841h220b94e4wdbf000a729f8992c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 1 Oct 2006, Eric Rannaud wrote:
>
> Indeed, the following -mm patch from Alan Cox is missing:
> pci-quirks-update.patch

Please don't send on patches with authorship information destroyed, and 
without adding the proper sign-offs.. (It also looks like you destroyed 
white-space, so it wouldn't apply even if it was otherwise valid).

		Linus
