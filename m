Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131397AbQKJTE4>; Fri, 10 Nov 2000 14:04:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131457AbQKJTEq>; Fri, 10 Nov 2000 14:04:46 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:62221 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S131397AbQKJTEn>; Fri, 10 Nov 2000 14:04:43 -0500
Message-ID: <3A0C45DD.5BE62345@timpanogas.org>
Date: Fri, 10 Nov 2000 12:00:45 -0700
From: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Organization: TRG, Inc.
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: Richard A Nelson <cowboy@vnet.ibm.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [Fwd: sendmail fails to deliver mail with attachments in 
 /var/spool/mqueue]
In-Reply-To: <Pine.LNX.4.30.0011101358400.19584-100000@back40.badlands.lexington.ibm.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Richard A Nelson wrote:
> 
> Any `real` reason you're still at 8.9.3?   Current is 8.11.1
> 
> If you send me a note of the type that fails, (to cowboy@debian.org),
> it'll get received on both a 2.2.18-21/8.11.1 and 2.4.0-test10/8.11.2.Beta0

8.11.1 has problems talking to older sendmails and qmail.  I've seen
even worse problems on 8.11.1, and backreved it immediately, and the
encryption stuff has a lot of build problems on Linux. 

Jeff  


> system.
> 
> --
> Rick Nelson
> 'Mounten' wird für drei Dinge benutzt: 'Aufsitzen' auf Pferde, 'einklinken'
> von Festplatten in Dateisysteme, und, nun, 'besteigen' beim Sex.
>         -- Christa Keil
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
