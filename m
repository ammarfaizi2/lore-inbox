Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261193AbVEaTFs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261193AbVEaTFs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 15:05:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261259AbVEaTFo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 15:05:44 -0400
Received: from cog1.w2cog.org ([206.251.188.12]:35456 "EHLO w2cog.org")
	by vger.kernel.org with ESMTP id S261193AbVEaTBK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 15:01:10 -0400
Date: Tue, 31 May 2005 14:00:46 -0500 (CDT)
From: Roy Keene <rkeene@psislidell.com>
To: bernd-schubert@gmx.de
cc: linux-kernel@vger.kernel.org
Subject: Re: Problem with 2.6 kernel and lots of I/O
In-Reply-To: <200505312040.30812.bernd-schubert@web.de>
Message-ID: <Pine.LNX.4.62.0505311350330.7546@hammer.psislidell.com>
References: <Pine.LNX.4.62.0505311042470.7546@hammer.psislidell.com>
 <200505312040.30812.bernd-schubert@web.de>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-306218877-1117566046=:7546"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-306218877-1117566046=:7546
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE

Bernd,

 =09The ENBD project requires a kernel patch for 2.6 support and I=20
would like to remain with the vendor supplied (and "blessed" kernel) for=20
support reasons.

 =09Since I cannot provide feedback on the latest version of the=20
kernel and I don't want to have an "unblessed" kernel, I've opened a=20
ticket with RedHat attached to my support contract for this problem.  I=20
mainly posted my question here to see if this was a known issue with 2.6=20
in general or NBD-specific.

 =09I had not heard of "DRBD" before now, but it looks interesting.  I=20
am looking into it further.

Thanks,
 =09Roy Keene

On Tue, 31 May 2005, Bernd Schubert wrote:

> Hello Roy,
>
> Roy Keene wrote:
>
>> Hello,
>>
>> =A0=A0I=A0have=A0a=A0(well,=A0at=A0least=A0one)=A0show-stopping=A0proble=
ms=A0with=A0the=A02.6
>> kernel while doing heavy I/O.=A0=A0I=A0have=A0a=A0(software)=A0RAID1=A0o=
f=A0network=A0block
>> devices (nbd0 and nbd1) set up on two identical machines in an
>
> what about using drbd or enbd? AFAIK both are much better tested/suited f=
or
> network raid.
>
> Cheers,
> =A0Bernd
>
>
> --=20
> Bernd Schubert
> PCI / Theoretische Chemie
> Universit=E4t Heidelberg
> INF 229
> 69120 Heidelberg
> e-mail: bernd.schubert@pci.uni-heidelberg.de
>
--8323328-306218877-1117566046=:7546--
