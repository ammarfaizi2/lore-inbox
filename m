Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751067AbWBBNcX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751067AbWBBNcX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 08:32:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751071AbWBBNcX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 08:32:23 -0500
Received: from webmail.terra.es ([213.4.149.12]:13055 "EHLO
	csmtpout2.frontal.correo") by vger.kernel.org with ESMTP
	id S1751070AbWBBNcW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 08:32:22 -0500
Date: Thu, 2 Feb 2006 14:24:43 +0100 (added by postmaster@terra.es)
From: <grundig@teleline.es>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: xavier.bestel@free.fr, schilling@fokus.fraunhofer.de, oliver@neukum.org,
       mrmacman_g4@mac.com, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org, jerome.lacoste@gmail.com,
       jengelh@linux01.gwdg.de, James@superbug.co.uk, j@bitron.ch,
       acahalan@gmail.com
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-Id: <20060202143202.3c2bd4a3.grundig@teleline.es>
In-Reply-To: <43E20047.nail4TP1PULVQ@burner>
References: <787b0d920601241858w375a42efnc780f74b5c05e5d0@mail.gmail.com>
	<43DF3C3A.nail2RF112LAB@burner>
	<5a2cf1f60601310424w6a64c865u590652fbda581b06@mail.gmail.com>
	<200601311333.36000.oliver@neukum.org>
	<1138867142.31458.3.camel@capoeira>
	<43E1EAD5.nail4R031RZ5A@burner>
	<1138880048.31458.31.camel@capoeira>
	<43E20047.nail4TP1PULVQ@burner>
X-Mailer: Sylpheed version 2.1.9 (GTK+ 2.8.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Thu, 02 Feb 2006 13:51:19 +0100,
Joerg Schilling <schilling@fokus.fraunhofer.de> escribió:

> Libscg is _the_ HAL for cdrecord. It is availaible the same way as today since
> 10 years.


libscg being there for 10 years doesn't means that it's the right or the
better way of doing things.

Hal is _the_ HAL for linux, in fact HAL is targetted to become _the_
"standard" (freedesktop standard) HAL for open operative systems. HAL
should be already available on solaris, at least there's a @sun.com guy
who created a hald/solaris/ directory (gnome is already using HAL and
sun is interested in gnome). It doesn't seem to do nothing today but I
bet that sun is interested in getting HAL working in solaris (there're
at least people in the opensolaris mailing lists interested). I guess
the BSD guys will end up implementing BSD support some day aswell - desktop
is not as important for them as it is for linux.

So the fact is that HAL is quickly becoming _the_ HAL for unix systems.
