Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271241AbRHZCHt>; Sat, 25 Aug 2001 22:07:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271244AbRHZCHk>; Sat, 25 Aug 2001 22:07:40 -0400
Received: from jive.SoftHome.net ([204.144.231.93]:37314 "EHLO softhome.net")
	by vger.kernel.org with ESMTP id <S271241AbRHZCH3>;
	Sat, 25 Aug 2001 22:07:29 -0400
From: "John L. Males" <jlmales@softhome.net>
Organization: Toronto, Ontario, Canada
To: Keith Owens <kaos@ocs.com.au>
Date: Sat, 25 Aug 2001 22:07:41 -0500
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re[03]: Kernel 2.4.8 - No rule to make target `/etc/sound/dsp001.ld' 
Reply-to: jlmales@softhome.net
CC: linux-kernel@vger.kernel.org
Message-ID: <3B8821AD.20775.1CE568C@localhost>
In-Reply-To: Your message of "Sat, 25 Aug 2001 19:06:29 EST."             <3B87F735.10072.1286FAC@localhost> 
In-Reply-To: <13654.998790096@ocs3.ocs-net>
X-mailer: Pegasus Mail for Win32 (v3.12c)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Keith,

Thanks for the insight.  I do try to tell the truth about my system,
but I do tend to compile for a multipurpose kernel.  This is often
driven by specific QA testing methology requirements I need in a
larger scope of requirements.  Hence why I configured 'Have DSPxxx.LD
firmware file' to yes.

I do read each and every one of the kernel help's associated with
each configuration item.  I was not aware I needed the .LD file at
time of compiling the kernel.  Perhaps it would be something to add
to the Kernel "To Do" list for the Help on  'Have DSPxxx.LD firmware
file' to be a bit more specific on the requirement as you have
pointed out.  Just a thought, for those of us who do read the
associated help items when compiling a kernel.  I insist on reading
each item when I compile a kernel, even when doing the exact same
Kernel again, to be certain I remembered what I need to know, as I
cannot remember all the details, nor compile a Kernel that often to
comit all this infor to my head.

As for the nested PGP, that was my error not the mail program I used.
 As a result of my own error the nested PGP signature as well as the
attachments were processed by PGP the way they were.  That was not my
intent.  Sorry for my error on the PGP of the original eMail I sent.

I do thank you for taking the time and offering the insight for this
issue I had.  It does help.  when I get a chance I will see if
perhaps I can figure out where and the format of the Help information
is and see if I can send in a proposed change as a result of this
issue I had.


Regards,

John L. Males
Willowdale, Ontario
Canada
25 August 2001 22:07
mailto:jlmales@softhome.net


From:           	Keith Owens <kaos@ocs.com.au>
To:             	jlmales@softhome.net
Copies to:      	linux-kernel@vger.kernel.org
Subject:        	Re: Kernel 2.4.8 - No rule to make target
`/etc/sound/dsp001.ld' 
Date sent:      	Sun, 26 Aug 2001 11:41:36 +1000

> On Sat, 25 Aug 2001 19:06:29 -0500, 
> "John L. Males" <jlmales@softhome.net> wrote:
> >I started trying out the 2.4 Kernel starting with 2.4.5 and have
> >had compiling problems.  The problem is I cannot complete the
> >compile of the modules due to an error "No rule to make target
> >`/etc/sound/dsp001.ld".  I have expereinced this error right up to
> >the 2.4.8 kernel.
> 
> You said yes to config 'Have DSPxxx.LD firmware file'
> CONFIG_PSS_HAVE_BOOT and also said that the firmware file is in
> /etc/sound/dsp001.ld but you do not have that file.  Turn off
> CONFIG_PSS_HAVE_BOOT or provide the file, either way you need to
> tell config the truth about your system.
> 
> PS.  Fix your mailer, you are sending nested PGP signatures, with
>      separate signatures on the text and attachment sections.
> 


-----BEGIN PGP SIGNATURE-----
Version: PGPfreeware 6.5.8 for non-commercial use 
<http://www.pgp.com>

iQA/AwUBO4hn9eAqzTDdanI2EQIZlACfTjaAAPEOeCwVcMdSD1jZKzntJqMAniXC
IV3tVb96FCexzNI4WfCKkx+V
=07ie
-----END PGP SIGNATURE-----



"Boooomer ... Boom Boom, how are you Boom Boom" Boomer 1985 - February/2000
