Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262747AbRE0FFR>; Sun, 27 May 2001 01:05:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262750AbRE0FFH>; Sun, 27 May 2001 01:05:07 -0400
Received: from tomts13.bellnexxia.net ([209.226.175.34]:50133 "EHLO
	tomts13-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S262747AbRE0FE6>; Sun, 27 May 2001 01:04:58 -0400
To: "CML2" <linux-kernel@vger.kernel.org>
Cc: <kbuild-devel@lists.sourceforge.net>
Subject: Re: [kbuild-devel] Configure.help entries wanted
In-Reply-To: <20010525012200.A5259@thyrsus.com> <3B0F3268.A671BC7A@pocketpenguins.com> <002401c0e5aa$0049a000$47a6b3d0@Toshiba> <3B0F8042.90DD5C5D@pocketpenguins.com> <005801c0e614$b49a0120$44a6b3d0@Toshiba>
From: Bill Pringlemeir <bpringle@sympatico.ca>
Date: 27 May 2001 01:03:20 -0400
In-Reply-To: "Jaswinder Singh"'s message of "Sat, 26 May 2001 11:50:15 -0700"
Message-ID: <m2k833z8mf.fsf@sympatico.ca>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 >>  The class of machines for which this option does not apply is
 >> "machines with an existing operating system in mask rom and no
 >> flash", which AFAICT is equivalent to "WindowsCE machines ".  The

>>>>> "JS" == Jaswinder Singh <jaswinder.singh@3disystems.com> writes:

 JS> AFAIK WindowsCE machines are also broad term.

Windows CE also implies that the device has an MMU.  As opposed to a
Revo (sp), Palm, etc. device.  I think that most Linux ports need the
MMU (ucLinux excluded)... Too technical a description in the help
wouldn't be much help at all, in my opinion.

regards,
Bill Pringlemeir.


