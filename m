Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272249AbRIKBV0>; Mon, 10 Sep 2001 21:21:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272247AbRIKBVR>; Mon, 10 Sep 2001 21:21:17 -0400
Received: from static004-9-151-24.nt02-c4.cpe.charter-ne.com ([24.151.9.4]:31824
	"EHLO Jupiter.LIWAVE.COM") by vger.kernel.org with ESMTP
	id <S272244AbRIKBU6>; Mon, 10 Sep 2001 21:20:58 -0400
Reply-To: <rvandam@liwave.com>
From: "Ron Van Dam" <rvandam@liwave.com>
To: "'Chris Siebenmann'" <cks@utcc.utoronto.ca>,
        <linux-kernel@vger.kernel.org>
Subject: RE: FW: OT: Integrating Directory Services for Linux
Date: Mon, 10 Sep 2001 21:20:56 -0400
Message-ID: <002201c13a60$022e1350$1f0201c0@w2k001>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook 8.5, Build 4.71.2173.0
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
In-Reply-To: <01Sep10.181449edt.63201@gpu.utcc.utoronto.ca>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Siebenmann wrote:
>> What if some less then enthusiastic has semi-mangled a /etc file.

> Then the registry breaks in the same way. There is always something
>that someone can do to screw the machine up; moving where most of the
>data is stored doesn't change that. At most it reduces the number of
>knobs someone can break off.

Not true. First I would like to say the a directory service isn't a
registry. It's a database to store information in a organized system. There
is nothing organized about the windows registry! The window registry is
nothing more than a huge INI file with bits and pieces of information
everywhere. It has no schema to pervent anyone from adding an bits of
information anywhere they want.

With a text file I can put anything in it. I can make a 100 MB resolv.conf
file if I wanted too. With a structured schema, the configuration can pretty
much be locked down what information is summitted or changed.

> No one dealing with a large collective of Unix machines is managing
>them on a one-by-one basis. They are driving configurations out of a
>central system for managing them, in some form or way, and if they have
>any sense individualization is strongly discouraged if not exterminated.
>(There are some quite elaborate systems for doing this, going so far as
>to store everything in SQL databases. See various LISA proceedings.)

Do you see DS as a bad thing for Linux? Tell why you think having a DS
system for Linux would be a terrible waste?

Thanks,
Ron

