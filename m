Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280460AbRJaUAa>; Wed, 31 Oct 2001 15:00:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280461AbRJaUAU>; Wed, 31 Oct 2001 15:00:20 -0500
Received: from boreas.isi.edu ([128.9.160.161]:26583 "EHLO boreas.isi.edu")
	by vger.kernel.org with ESMTP id <S280460AbRJaUAG>;
	Wed, 31 Oct 2001 15:00:06 -0500
To: Larry McVoy <lm@bitmover.com>
cc: Rik van Riel <riel@conectiva.com.br>, Timur Tabi <ttabi@interactivesi.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: [OT] Module Licensing? 
In-Reply-To: Your message of "Wed, 31 Oct 2001 09:22:28 PST."
             <20011031092228.J1506@work.bitmover.com> 
Date: Wed, 31 Oct 2001 11:55:01 -0800
Message-ID: <4986.1004558101@ISI.EDU>
From: Craig Milo Rogers <rogers@ISI.EDU>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Since your program, which happens to consist of one open
>> source part and one proprietary part, is partly a derived
>> work from the kernel source (by using kernel header files
>> and the inline functions in it) your whole work must be
>> distributed under the GPL.
>
>This is obviously incorrect, that would say that
>
>	#include <sys/types.h>
>
>means my app is now GPLed.  Good luck enforcing that.

	Your compiled object module might be a derived work, hence its
distribution would be restricted by the terms of the GPL version 2.
Your source code file would not be a derived work (under certain
currently widely-held assumptions about interface copyrights), and
hence could be distributed without restriction by the GPL.

	Usual disclaimer:  I am not a lawyer.

					Craig Milo Rogers
