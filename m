Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266853AbSLDQHG>; Wed, 4 Dec 2002 11:07:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266886AbSLDQHF>; Wed, 4 Dec 2002 11:07:05 -0500
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:32775 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S266853AbSLDQHF>; Wed, 4 Dec 2002 11:07:05 -0500
Date: Wed, 4 Dec 2002 17:14:30 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Robinson Maureira Castillo <rmaureira@alumno.inacap.cl>
cc: linux-kernel@vger.kernel.org
Subject: Re: Strange options when doing make allnoconfig
In-Reply-To: <Pine.LNX.4.44.0212041248370.20359-100000@alumno.inacap.cl>
Message-ID: <Pine.LNX.4.44.0212041710490.2109-100000@serv>
References: <Pine.LNX.4.44.0212041248370.20359-100000@alumno.inacap.cl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 4 Dec 2002, Robinson Maureira Castillo wrote:

> CONFIG_SOUND_GAMEPORT=y
> CONFIG_MSDOS_PARTITION=y
> 
> Are this included on purpose, or did they just slipped? 8)

These are derived symbols, so this is correct. allnoconfig just means that 
all questions are answered with no, not that all symbols are set to no.

bye, Roman

