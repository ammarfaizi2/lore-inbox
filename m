Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266797AbUAWXsv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 18:48:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266798AbUAWXsu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 18:48:50 -0500
Received: from nms.rz.uni-kiel.de ([134.245.1.2]:54494 "EHLO uni-kiel.de")
	by vger.kernel.org with ESMTP id S266797AbUAWXsi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 18:48:38 -0500
From: Mike Gabriel <mgabriel@ecology.uni-kiel.de>
Reply-To: mgabriel@ecology.uni-kiel.de
Organization: OEZK, CAU Kiel
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: vt6410 in kernel 2.6
Date: Sat, 24 Jan 2004 00:47:19 +0100
User-Agent: KMail/1.5.4
References: <200401222238.09157.mgabriel@ecology.uni-kiel.de> <4011AE4C.5050408@pobox.com>
In-Reply-To: <4011AE4C.5050408@pobox.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200401240047.19261.mgabriel@ecology.uni-kiel.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi jeff,

> > is there any chance of upcoming support for the vt6410 ide/raid chipset
> > in the 2.6.x kernel? there has been an attempt by via itself, but it only
> > suits redhat 7.2 kernels and systems, thus it is highly specific. is
> > there any1 who is working on that?
>
> It should already be in there.

can you tell me the exact kernel-config-option or the menuconfig line? i have 
looked for it and couldn't find it. also most of the google hits were 
negative. there weren't many, either.

> Note that it is not really RAID...  just software RAID.

yeeah, don't care. i wanna use it in jobd mode in connection with the md 
driver.

mike

-- 

netzwerkteam - oekologiezentrum
Mike Gabriel
FA Geobotanik
Christian-Albrecht Universit‰t zu Kiel
Abt. Prof. Dr. K. Dierﬂen
Olshausenstr. 75
24118 kiel

fon-oezk: +49 431 880 1186
fon-home: +49 431 64 74 196

mail: mgabriel@ecology.uni-kiel.de
http://www.ecology.uni-kiel.de

