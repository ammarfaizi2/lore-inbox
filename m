Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129267AbRAFA6X>; Fri, 5 Jan 2001 19:58:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129324AbRAFA6N>; Fri, 5 Jan 2001 19:58:13 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:64017 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129267AbRAFA6D>; Fri, 5 Jan 2001 19:58:03 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Linux 2.4.0-ac2
Date: 5 Jan 2001 16:57:55 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <935qij$62d$1@cesium.transmeta.com>
In-Reply-To: <E14Eale-000873-00@the-village.bc.nu> <20010105140246.A838@evaner.penguinpowered.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20010105140246.A838@evaner.penguinpowered.com>
By author:    Evan Thompson <evaner@bigfoot.com>
In newsgroup: linux.dev.kernel
>
> Hmm...seems as though Alan released 2.4.0-ac2 1 year ago (check out
> the time stamps on ftp.kernel.org/pub/linux/kernel/people/alan/2.4/)
>

zeus 1 % ls -l /pub/linux/kernel/people/alan/2.4/
total 4400
-rw-r--r--   1 korg     korg      1015191 Jan  4 17:44 patch-2.4.0-ac1.bz2
-rw-r--r--   1 korg     korg          248 Jan  4 17:44 patch-2.4.0-ac1.bz2.sign
-rw-r--r--   1 korg     korg      1211734 Jan  4 17:44 patch-2.4.0-ac1.gz
-rw-r--r--   1 korg     korg          248 Jan  4 17:44 patch-2.4.0-ac1.gz.sign
-rw-r--r--   1 korg     korg      1020542 Jan  5 09:21 patch-2.4.0-ac2.bz2
-rw-r--r--   1 korg     korg          248 Jan  5 09:21 patch-2.4.0-ac2.bz2.sign
-rw-r--r--   1 korg     korg      1219124 Jan  5 09:21 patch-2.4.0-ac2.gz
-rw-r--r--   1 korg     korg          248 Jan  5 09:21 patch-2.4.0-ac2.gz.sign


This is why I hate FTP.  This ALWAYS happens to someone when their FTP
client tries to be smart and convert dates incorrectly.

       -hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
