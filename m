Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264345AbRFHVjO>; Fri, 8 Jun 2001 17:39:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264371AbRFHVjF>; Fri, 8 Jun 2001 17:39:05 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:26126 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S264347AbRFHVi6>;
	Fri, 8 Jun 2001 17:38:58 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200106082138.f58LcW9248692@saturn.cs.uml.edu>
Subject: Re: temperature standard - global config option?
To: lk@Aniela.EU.ORG (L. K.)
Date: Fri, 8 Jun 2001 17:38:31 -0400 (EDT)
Cc: acahalan@cs.uml.edu (Albert D. Cahalan),
        mhw@wittsend.com (Michael H. Warfield), bootc@worldnet.fr (Chris Boot),
        isch@ecce.homeip.net (mirabilos {Thorsten Glaser}),
        linux-kernel@vger.kernel.org (linux-kernel@vger.kernel.org)
In-Reply-To: <Pine.LNX.4.21.0106090018110.4712-100000@ns1.Aniela.EU.ORG> from "L. K." at Jun 09, 2001 12:22:50 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

L. K. writes:
> On Fri, 8 Jun 2001, Albert D. Cahalan wrote:

>> The bits are free; the API is hard to change.
>> Sensors might get better, at least on high-end systems.
>> Rounding gives a constant 0.15 degree error.
>> Only the truly stupid would assume accuracy from decimal places.
>> Again, the bits are free; the API is hard to change.
>>
>> One might provide other numbers to specify accuracy and precision.
>
> I really do not belive that for a CPU or a motherboard +- 1 degree would
> make any difference.
>
> If a CPU runs fine at, say, 37 degrees C, I do not belive it will have any
> problems running at 38 or 36 degrees. I support the ideea of having very
> good sensors for temperature monitoring, but CPU and motherboard
> temperature do not depend on the rise of the temperature of 1 degree, but
> when the temperature rises 10 or more degrees. I hope you understand what
> I want to say.

Of course I understand. Motorola offers 4-degree resolution,
with a random offset of up to 12 degrees. (calibration is possible)
You seem to need another reminder that THE BITS ARE FREE.

Why would you even consider trying to squeeze out a few bits?
You can't be absolutely sure that they will never be useful.
