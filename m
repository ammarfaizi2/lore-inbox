Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276786AbRJUVUA>; Sun, 21 Oct 2001 17:20:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276800AbRJUVTv>; Sun, 21 Oct 2001 17:19:51 -0400
Received: from mailhost.idcomm.com ([207.40.196.14]:10676 "EHLO
	mailhost.idcomm.com") by vger.kernel.org with ESMTP
	id <S276786AbRJUVTe>; Sun, 21 Oct 2001 17:19:34 -0400
Message-ID: <3BD33C2F.9A948EC6@idcomm.com>
Date: Sun, 21 Oct 2001 15:20:47 -0600
From: "D. Stimits" <stimits@idcomm.com>
Reply-To: stimits@idcomm.com
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre1-xfs-4 i686)
X-Accept-Language: en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: The new X-Kernel !
In-Reply-To: <E15vO29-0008ED-00@calista.inka.de> <15vPqi-1pZTN2C@fmrl02.sul.t-online.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Jansen wrote:
> 
> On Sunday 21 October 2001 21:13, Bernd Eckenfels wrote:
> > Well, it is not a question of moving X or Office into Kernel Space. But
> > current development clearly shows, that some things like Video Card Access
> > need Kernel Support. IMHO the Amount of GDI related Functions in NT Kernel
> > are too much, but X11 is not exactly the Windowing System you can consider
> > well suited for Desktop and Game Use.
> 
> Actually some gfx code has already been moved into the kernel, see DRI and
> the nvidia kernel modules. And AFAIK there aren't any noticably speed
> differences between nvidia's linux drivers and the Windows drivers, at least
> not for 3D, so X11 can't be that bad.

It isn't bad at all. My GeForce I DDR typically exceeds 300 FPS, and
approaches 400 FPS, on 32 bit, 640x480. It goes down at higher
resolution of course, but it is insanely fast compared to tech from just
a short time ago in history. People are reading old information and hear
about the theoretical problems of X11, without realizing direct
rendering works just fine on X11 (it's just a matter of writing the
software to do it, the effort started at a later date than with Win, and
is sometimes crippled by manufacturers hiding information). Even on Win,
bad drivers cause very bad performance. I'd love to see the day that Win
can crash its graphics interface and survive without bringing the
machine down.

D. Stimits, stimits@idcomm.com

> 
> bye...
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
