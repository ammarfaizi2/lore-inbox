Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965148AbWACXwK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965148AbWACXwK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 18:52:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965167AbWACXwJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 18:52:09 -0500
Received: from rudy.mif.pg.gda.pl ([153.19.42.16]:11100 "EHLO
	rudy.mif.pg.gda.pl") by vger.kernel.org with ESMTP id S965144AbWACXv6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 18:51:58 -0500
Date: Wed, 4 Jan 2006 00:51:52 +0100 (CET)
From: =?ISO-8859-2?Q?Tomasz_K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>
To: Adrian Bunk <bunk@stusta.de>
cc: Jesper Juhl <jesper.juhl@gmail.com>, Takashi Iwai <tiwai@suse.de>,
       Olivier Galibert <galibert@pobox.com>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, Andi Kleen <ak@suse.de>,
       perex@suse.cz, alsa-devel@alsa-project.org, James@superbug.demon.co.uk,
       sailer@ife.ee.ethz.ch, linux-sound@vger.kernel.org, zab@zabbo.net,
       kyle@parisc-linux.org, parisc-linux@lists.parisc-linux.org,
       jgarzik@pobox.com, Thorsten Knabe <linux@thorsten-knabe.de>,
       zwane@commfireservices.com, zaitcev@yahoo.com,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal
In-Reply-To: <20060103231009.GI3831@stusta.de>
Message-ID: <Pine.BSO.4.63.0601040048010.29027@rudy.mif.pg.gda.pl>
References: <200601031522.06898.s0348365@sms.ed.ac.uk> <20060103160502.GB5262@irc.pl>
 <200601031629.21765.s0348365@sms.ed.ac.uk> <20060103170316.GA12249@dspnet.fr.eu.org>
 <s5h1wzpnjrx.wl%tiwai@suse.de> <20060103203732.GF5262@irc.pl>
 <s5hvex1m472.wl%tiwai@suse.de> <9a8748490601031256x916bddav794fecdcf263fb55@mail.gmail.com>
 <20060103215654.GH3831@stusta.de> <20060103221314.GB23175@irc.pl>
 <20060103231009.GI3831@stusta.de>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-810093645-1136332312=:29027"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-810093645-1136332312=:29027
Content-Type: TEXT/PLAIN; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT

On Wed, 4 Jan 2006, Adrian Bunk wrote:
[..]
>>   OSS is universal cross-unix API. ALSA is Linux-only.
>
> How "universal cross-unix" is the OSS API really?
>
> Which operating systems besides Linux have a native sound system
> supporting the OSS API [1]?
>
> I know about FreeBSD and partial support in NetBSD.
>
> Are there any other [2]?

Solaris, AIX ..
Full list is avalaible in "Operating System" listbox on 
http://www.4front-tech.com/download.cgi

kloczek
-- 
-----------------------------------------------------------
*Ludzie nie maj± problemów, tylko sobie sami je stwarzaj±*
-----------------------------------------------------------
Tomasz K³oczko, sys adm @zie.pg.gda.pl|*e-mail: kloczek@rudy.mif.pg.gda.pl*
--0-810093645-1136332312=:29027--
