Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317942AbSFNP5q>; Fri, 14 Jun 2002 11:57:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317944AbSFNP5p>; Fri, 14 Jun 2002 11:57:45 -0400
Received: from d12lmsgate-3.de.ibm.com ([195.212.91.201]:19106 "EHLO
	d12lmsgate-3.de.ibm.com") by vger.kernel.org with ESMTP
	id <S317942AbSFNP5n> convert rfc822-to-8bit; Fri, 14 Jun 2002 11:57:43 -0400
Importance: Normal
Sensitivity: 
Subject: Re: [PATCH] Take 2: Consolidate sys32_utime
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: ralf@gnu.org, "David Engebretsen" <engebret@us.ibm.com>,
        "BOEBLINGEN LINUX390" <LINUX390@de.ibm.com>, davem@redhat.com,
        ak@suse.de, davidm@hpl.hp.com, anton@samba.org, paulus@samba.org,
        LKML <linux-kernel@vger.kernel.org>
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OF37DF8EF6.96E04608-ONC1256BD8.002E815A@de.ibm.com>
From: "Martin Schwidefsky" <schwidefsky@de.ibm.com>
Date: Fri, 14 Jun 2002 10:29:57 +0200
X-MIMETrack: Serialize by Router on D12ML016/12/M/IBM(Release 5.0.9a |January 7, 2002) at
 14/06/2002 10:33:05
MIME-Version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>In case anyone is wondering, I have not even built this as I don't have
>easy access to any of these architectures ... Caveat Empor
>(It would be nice if someone could try a build for each architecture
>to iron out any obvious problems before I launch into even more
>of these. HINT, HINT.)

Yeah, yeah, got the hint... the new sys32_utime works on s390x.

blue skies,
   Martin

Linux/390 Design & Development, IBM Deutschland Entwicklung GmbH
Schönaicherstr. 220, D-71032 Böblingen, Telefon: 49 - (0)7031 - 16-2247
E-Mail: schwidefsky@de.ibm.com


