Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292635AbSBZSPL>; Tue, 26 Feb 2002 13:15:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292612AbSBZSPE>; Tue, 26 Feb 2002 13:15:04 -0500
Received: from ithilien.qualcomm.com ([129.46.51.59]:61433 "EHLO
	ithilien.qualcomm.com") by vger.kernel.org with ESMTP
	id <S292638AbSBZSOi> convert rfc822-to-8bit; Tue, 26 Feb 2002 13:14:38 -0500
Message-Id: <5.1.0.14.2.20020226101117.01aa4628@mail1.qualcomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 26 Feb 2002 10:14:11 -0800
To: vda@port.imtp.ilyichevsk.odessa.ua, linux-kernel@vger.kernel.org
From: Maksim Krasnyanskiy <maxk@qualcomm.com>
Subject: Re: [RFC] List of maintainers (draft #2)
In-Reply-To: <200202061008.g16A8Ct29437@Port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Denis,

I though I asked you to include me on that list.
Anyway here it is again.

Maksim Krasnyanskiy <maxk@qualcomm.com)
         Universal TUN/TAP driver author / maintainer
         Bluetooth subsytem (BlueZ) author / maintainer

Thanks
Max

>After recent discussion on Linux development practices I think it may be
>worthy to have list of lk maintainers. Unlike one included into kernel
>source, this document is meant to be monthly (weekly?) mailed to lkml
>and to be modified whenever new victim wishes to be listed in it
>or someone can no longer devote his time to maintainer work.
>
>This is a draft. I picked some names and addresses and made entried for them.
>If you want to be in this list, mail me your corrected entry. Please indicate
>what kind of reports you wish to receive and what kind of reports you DON'T
>want to see.
>
>I want these entries to sound like "Hey, I am working on these parts of the
>kernel, if you have something, send it to me not to Linus". With precise
>indication of those parts and your level of involvement:
>
>If you don't want to be in this list, mail me too - I'll remove your entry.
>
>Note that English isn't my native language, feel free to correct any mistakes.
>--
>vda
>
>* * * * DRAFT * * * *
>
>So, you are new to Linux kernel hacking and want to submit a kernel bug
>report but don't know how to do it and _where_ to report it?
>
>Preparing bug report:
>=====================
>Oops: decode it with ksymoops
>Unkillable process: Alt-SysRq-T and ksymoops relevant part
>(yes it means you should have ksymoops installed and tested!)
>
>Sending bug report/patch:
>=========================
>* It never hurts to send to Linux kernel mailing list.
>* Some device drivers have active developers, try to contact them first
>* Otherwise find a subsystem maintainer to which your report pertains
>   and send report to his address.
>* Small fixes and device driver updates are best directed to subsystem
>   maintainers and "small bits" integrators.
>* Do not send it to all addresses at once! This will annoy lots of people
>   and isn't useful at all.
>* Do NOT send it to Linus.
>* If your patch is something big and new, announce it on lkml and try
>   to attract testers. After it has been tested and discussed, you can
>   expect Linus to consider inclusion in mainline.
>
>Note that this list is sorted in reversed date order, most recent entries
>first. This means than entries at bottom can be outdated :-(
>
>
>                 Current Linux kernel people
>
>Linux kernel mailing list <linux-kernel@vger.kernel.org> [05 feb 2002]
>         Post anything related to Linux kernel here, but nothing else :-)
>
>Richard Gooch <rgooch@ras.ucalgary.ca> [5 feb 2002]
>         I maintain devfs. I want people to Cc: me when reporting devfs
>         problems, since I don't read all messages on linux-kernel.
>         Send devfs related patches to me directly, rather than
>         bypassing me and sending to Linus/Marcelo/Alan/Dave etc.
>
>Andrew Morton <akpm@zip.com.au> [05 feb 2002]
>         I'm receptive to any reproducible bug anywhere in the 2.4 kernel.
>         Specialising in ext2, ext3 and network drivers.
>         Not thinking about 2.5.x at this time.
>
>Petr Vandrovec <vandrove@vc.cvut.cz> [05 feb 2002]
>         ncpfs filesystem, matrox framebuffer driver, problems related
>         to VMware - in all of 2.2.x, 2.4.x and 2.5.x.
>
>Reiserfs developers list <reiserfs-dev@namesys.com> [05 feb 2002]
>         Send all reiserfs-related stuff here including but not limited to bug
>         reports, fixes, suggestions
>
>Oleg Drokin <green@linuxhacker.ru> [05 feb 2002]
>         SA11x0 USB-ethernet and SA11x0 watchdog are mine
>
>Vojtech Pavlik <vojtech@ucw.cz> [05 feb 2002]
>         Feel free to send me bug reports and patches to input device drivers
>         (drivers/input/*, drivers/char/joystick/*)
>         I also want to receive bug reports and patches for following
>         USB drivers: printer, acm, catc, hid*, usbmouse, usbkbd, wacom.
>         All other (not in the list) USB driver changes should go to USB
>         maintainer (hopefully there is one listed here :-).
>         Also CC me if you are posting VIA IDE driver related message
>         (although I am not IDE subsystem maintainer).
>
>======= I am waiting confirmation from these people ========
>
>Alan Cox <alan@lxorguk.ukuu.org.uk> [5 feb 2002]
>         I am 2.2 maintainer.
>         I collect various bits and pieces for inclusion in 2.4
>
>Alexander Viro <viro@math.psu.edu> [5 feb 2002]
>         I am NOT a fs subsystem maintainer. But I won't kill
>         you if you send me some generic fs bug reports and (hopefully) 
> patches
>
>Andre Hedrick <andre@linux-ide.org> [5 feb 2002]
>         I am IDE guy.
>
>Andrea Arcangeli <andrea@suse.de> [5 feb 2002]
>         Send VM related bug reports and patches to me
>
>Arnaldo Carvalho de Melo <acme@conectiva.com.br> [5 feb 2002]
>         ?
>
>Dave Jones <davej@suse.de> [5 feb 2002]
>         I collect various bits and pieces for inclusion in 2.5,
>         espesially small and trivial ones and driver updates. Do not bother
>         Linus with them. I'll feed them to Linus when (and if) they
>         are proved to be worthy.
>
>David S. Miller <davem@redhat.com> [5 feb 2002]
>         ?
>
>Eric S. Raymond <esr@thyrsus.com> [5 feb 2002]
>         Send kernel configuration bug reports and suggestions to me.
>         Also I'll be more than happy to accept help enties for kernel config
>         options for Configure.help
>
>Greg KH <greg@kroah.com> [5 feb 2002]
>         ?
>
>Gérard Roudier <groudier@free.fr> [5 feb 2002]
>         I am SCSI guy
>
>H. Peter Anvin <hpa@zytor.com> [5 feb 2002]
>         ?
>
>Hans Reiser <reiser@namesys.com> [5 feb 2002]
>         ReiserFS is my favorite toy
>
>Ingo Molnar <mingo@elte.hu> [5 feb 2002]
>         New scheduler in 2.5 and Tux are mine
>
>James Simmons <jsimmons@transvirtual.com> [5 feb 2002]
>         Console and framebuffer sybsustems
>
>Jeff Garzik <jgarzik@mandrakesoft.com> [5 feb 2002]
>         ?
>
>Jens Axboe <axboe@suse.de> [5 feb 2002]
>         I am block device subsystem maintainer
>
>Keith Owens <kaos@ocs.com.au> [5 feb 2002]
>         ksymoops, kbuild, .. .. .. .. .  are mine
>
>Linus Torvalds <torvalds@transmeta.com> [5 feb 2002]
>         Do not send anything to me unless it is for 2.5, well tested,
>         discussed on lkml and is used by significant number of people.
>         In general it is a bad idea to send me small fixes and driver
>         updates, send them to subsystem maintainers and/or
>         "small stuff" integrator (currently Dave Jones, see his entry)
>         Sorry, I can't do everything.
>
>Marcelo Tosatti <marcelo@conectiva.com.br> [5 feb 2002]
>         Do not send anything to me unless it is for 2.4 and well tested.
>         If you are sending me small fixes and driver updates, send
>         a copy to subsystem maintainers and/or "small stuff" integrator
>         (currently Alan Cox, see his entry).
>
>Rik van Riel <riel@conectiva.com.br> [5 feb 2002]
>         Send me VM related stuff
>
>Robert Love <rml@tech9.net> [5 feb 2002]
>         Preemptible kernel is mine
>
>Russell King <rmk@arm.linux.org.uk> [5 feb 2002]
>         ?
>
>Rusty Russell <rusty@rustcorp.com.au> [5 feb 2002]
>         ?
>
>Trond Myklebust <trond.myklebust@fys.uio.no> [5 feb 2002]
>         I am NFS maintainer
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

