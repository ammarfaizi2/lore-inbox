Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932126AbWERSmU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932126AbWERSmU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 14:42:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751377AbWERSmU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 14:42:20 -0400
Received: from mailhost.terra.es ([213.4.149.12]:7891 "EHLO
	csmtpout3.frontal.correo") by vger.kernel.org with ESMTP
	id S1751340AbWERSmT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 14:42:19 -0400
Date: Thu, 18 May 2006 20:40:04 +0200 (added by postmaster@terra.es)
From: grundig <grundig@teleline.es>
To: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Cc: felipe.alfaro@gmail.com, jesper.juhl@gmail.com, linuxcbon@yahoo.fr,
       Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org
Subject: Re: replacing X Window System !
Message-Id: <20060518204131.3a87a27d.grundig@teleline.es>
In-Reply-To: <20060518154215.GG23933@csclub.uwaterloo.ca>
References: <200605171218.k4HCIt4L013978@turing-police.cc.vt.edu>
	<20060517123937.75295.qmail@web26605.mail.ukl.yahoo.com>
	<9a8748490605170639n12fde7c9i836599f02a30fd51@mail.gmail.com>
	<6f6293f10605171017y106565ev62683f04b353a2f5@mail.gmail.com>
	<20060517194438.1df682aa.grundig@teleline.es>
	<20060518154215.GG23933@csclub.uwaterloo.ca>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Thu, 18 May 2006 11:42:15 -0400,
lsorense@csclub.uwaterloo.ca (Lennart Sorensen) escribió:

> Wasn't it back in NT4 they moved it into kernel space to speed things
> up? :)

I suspect that moving everything back to userspace is not something that
they do because it's "The Right Thing", but because they need it. The
graphic subsystems that are people is starting to finish and that will
be used in the next years need to allow a huge amount of "personalization"
done by toolkits. XP already has some problems - you can only use "signed"
themes, themes probably have to be uploaded in the kernel and it's a
requeriment.


I wouldn't say that putting the graphic subsystem to speed things up was
an error - it had good sides. It _really_ speed up things, and it wasn't
that unstable - look at how high uptimes you can get with win2k/xp. In
Linux we also have a TCP/IP stack, filesystem, VT100 emulation...

It's certainly an error to do that today, but at that time it wasn't the
end of the world.
