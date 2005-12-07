Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964840AbVLGCG6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964840AbVLGCG6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 21:06:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965038AbVLGCG6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 21:06:58 -0500
Received: from smtp.terra.es ([213.4.129.129]:35713 "EHLO tsmtp1.mail.isp")
	by vger.kernel.org with ESMTP id S964840AbVLGCG5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 21:06:57 -0500
Date: Wed, 7 Dec 2005 03:06:35 +0100
From: "Wed, 7 Dec 2005 03:06:35 +0100" <grundig@teleline.es>
To: Coywolf Qi Hunt <coywolf@gmail.com>
Cc: luke-jr@utopios.org, linux-kernel@vger.kernel.org, rms@gnu.org
Subject: Re: Linux in a binary world... a doomsday scenario
Message-Id: <20051207030635.8d0a24c1.grundig@teleline.es>
In-Reply-To: <2cd57c900512061742s28f57b5eu@mail.gmail.com>
References: <21d7e9970512051610n1244467am12adc8373c1a4473@mail.gmail.com>
	<20051206040820.GB26602@kroah.com>
	<2cd57c900512052358m5b631204i@mail.gmail.com>
	<200512061856.42493.luke-jr@utopios.org>
	<2cd57c900512061742s28f57b5eu@mail.gmail.com>
X-Mailer: Sylpheed version 2.1.6 (GTK+ 2.8.3; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Wed, 7 Dec 2005 09:42:22 +0800,
Coywolf Qi Hunt <coywolf@gmail.com> escribió:

> 2005/12/7, Luke-Jr <luke-jr@utopios.org>:
> > No proprietary software here, excluding things such as firmware/BIOS where
> > there is no choice.
> 
> Why 'excluding'? You can't deny you are using proprietary software.
> Neither do us.

BIOS'es and firmware are not drivers or normal "processes". Firmware
doesn't deal with the internal kernel's locking for example- is a very
different thing. bios and firmware is pretty much part of the hardware,
pretty much like the chips' internal design: it just "does its work".
There's no of point on having open source bioses/firmware if you don't
have the design docs and all the related hardware info aswell.

(IOW: Saying that you'are using "propietary software" because you're
using a propietary BIOS is wrong, IMO - it's pretty much "propietary 
hardware" even if its software)
