Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319165AbSHTOhe>; Tue, 20 Aug 2002 10:37:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319167AbSHTOhe>; Tue, 20 Aug 2002 10:37:34 -0400
Received: from ns1.ionium.org ([62.27.22.2]:51468 "HELO mail.ionium.org")
	by vger.kernel.org with SMTP id <S319165AbSHTOhQ> convert rfc822-to-8bit;
	Tue, 20 Aug 2002 10:37:16 -0400
Content-Type: text/plain; charset=US-ASCII
From: Justin Heesemann <jh@ionium.org>
Organization: ionium Technologies
To: linux-kernel@vger.kernel.org
Subject: Re: P4 with i845E not booting with 2.4.19 / 3.5.31
Date: Tue, 20 Aug 2002 16:44:07 +0200
User-Agent: KMail/1.4.2
References: <3D6245DC.3A189656@hrzpub.tu-darmstadt.de> <3D62482D.4030500@myeastern.com>
In-Reply-To: <3D62482D.4030500@myeastern.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200208201644.07289.jh@ionium.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 20 August 2002 15:46, Rohan Deshpande wrote:
> Jens Wiesecke wrote:
> hi there,
>
> something to the same extent happened to me, with my P4, as ACPI caused
> a kernel panic.  if you have acpi enabled, try disabling it.

his problem sound a lot like mine.. never going further than Ok, booting the 
kernel. my chipset is a i845g.

it looks like the problems start with 2.4.19-pre7 which shows exactly this 
problem.
2.4.19-pre6 still works.

from the changelog pre6 to pre7 :

<wim@iguana.be> (02/04/07 1.383.2.6)
	[PATCH] 2.4.19-pre6 i8xx series chipsets patches

<wim@iguana.be> (02/04/07 1.383.2.7)
	[PATCH] 2.4.19-pre6 i8xx series chipsets patches

<wim@iguana.be> (02/04/07 1.383.2.8)
	[PATCH] 2.4.19-pre6 i8xx series chipsets patches

could this be the root of the problems ? Jens ? could you check please if you 
can boot pre6 and pre7 ?

--
Best Regards,
Justin Heesemann
