Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269570AbRHQDRv>; Thu, 16 Aug 2001 23:17:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269551AbRHQDRm>; Thu, 16 Aug 2001 23:17:42 -0400
Received: from dsl-216-227-46-73.telocity.com ([216.227.46.73]:9477 "HELO
	localhost.localdomain") by vger.kernel.org with SMTP
	id <S269541AbRHQDRa>; Thu, 16 Aug 2001 23:17:30 -0400
Content-Type: text/plain; charset=US-ASCII
From: tristan <fattymikefx@yahoo.com>
Reply-To: fattymikefx@yahoo.com
To: linux-kernel@vger.kernel.org
Subject: installing .01
Date: Thu, 16 Aug 2001 23:19:04 -0400
X-Mailer: KMail [version 1.3]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010817031904.3DFEF501D7@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

i just recently joined this mailing list because i need help.
And Linus suggested i join the kernel mailing list, and quote
his email to me as a starting point.
I want to install the linux kernel 0.01 on my 386 machine, and im
lost on how to do it.
I am 16 and only worked with linux for the last two years.
I see running .01 on my 386 as a learning experience into
the depths of the machine, and how to use assembly and work on
OSs. So i need some help here is what Linus told me:

>
> i would like to run linux on it. Im sure there are old distios i could find
> to install on the machine but i would have much more fun learning about
> the OS by install the .01 version of the kernel on the system, deleteing
> DOS and Windows 3.1 which are currently stinking up the computer.
> The problem is im not sure how to do this, and i cant find any documentation
> on installing a linux kernel unless i already have linux running.



Well, historically in order to be able to install the 0.01 kernel, you had
to have a full minix-386 distribution - that was the only way to make the
filesystem, and to copy the necessary files over etc.

And quite frankly, it's been ten years for me too, so I don't remember all
the details.

You probably don't have access to minix-386 anyway, so I suspect that
what you _should_ do is try to use a newer version of Linux to bootstrap
with. You need a really old compiler to compile Linux-0.01 with - I think
it needs gcc-1.40 or similar. It simply won't compile with newer
compilers.

All in all, yes, it can be done. I haven't done it personally in ten
years, and never hosted from Linux, though. I suspect your best option
would be to try to get a discussion going on how to do all this on the
kernel mailing list or similar, feel free to quote this email as a
starting point.

                        Linus

        I hope some one on this list can help me. If anyone has any 
information of helpfulness i would greatly appreciate it.

Thank you,
Tristan Sloughter
