Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317602AbSGOTAz>; Mon, 15 Jul 2002 15:00:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317603AbSGOTAy>; Mon, 15 Jul 2002 15:00:54 -0400
Received: from relay04.valueweb.net ([216.219.253.238]:28178 "EHLO
	relay04.valueweb.net") by vger.kernel.org with ESMTP
	id <S317602AbSGOTAx>; Mon, 15 Jul 2002 15:00:53 -0400
Message-ID: <3D331D01.F756F16B@opersys.com>
Date: Mon, 15 Jul 2002 15:05:37 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en, French/Canada, French/France, fr-FR, fr-CA
MIME-Version: 1.0
To: Miguel =?iso-8859-1?Q?Rodr=EDguez?= <agus_081074@yahoo.com>
CC: linux-kernel@vger.kernel.org, Adeos <adeos-main@mail.freesoftware.fsf.org>
Subject: Re: patchless debugger for U.P x86
References: <20020715183746.72137.qmail@web14205.mail.yahoo.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is just fantastic. I'm glad to see someone ran with the ideas of
patchless kernel debuggers as described in the Adeos paper and the likes.

There are definitely interfacing opportunities with the Adeos work
that's already been done using a kernel patch. Having both Adeos
as a kernel patch and as a patchless nanokernel is now really within
our reach.

Kudos to Miguel :)

Karim

Miguel Rodríguez wrote:
> 
> I have released an initial alpha release for a x86
> (uniprocessor) Linux kernel patchless debugger under
> the GNU GPL at savannah.gnu.org. Project is called
> kmdbg. First debugger implemented is a remote serial
> debugger.
> It is just a simple interrupt/exception/syscall
> interception scheleton and may have a lot of errors
> (or not work at all) although it worked for me with
> kernel 2.4.XX, 2.5.24.
> See:
> 
> https://savannah.gnu.org/projects/kmdbg
> 
> Miguel.
> 
> _______________________________________________________________
> Yahoo! Messenger
> Nueva versión: Webcam, voz, y mucho más ¡Gratis!
> Descárgalo ya desde http://messenger.yahoo.es
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
===================================================
                 Karim Yaghmour
               karim@opersys.com
      Embedded and Real-Time Linux Expert
===================================================
