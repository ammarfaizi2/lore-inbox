Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293193AbSCFEHZ>; Tue, 5 Mar 2002 23:07:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293201AbSCFEHO>; Tue, 5 Mar 2002 23:07:14 -0500
Received: from zok.SGI.COM ([204.94.215.101]:5314 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S293193AbSCFEHK>;
	Tue, 5 Mar 2002 23:07:10 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Jerrad Pierce <belg4mit@dirty-bastard.pthbb.org>
Cc: linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
Subject: Re: Tulip bug? 
In-Reply-To: Your message of "Tue, 05 Mar 2002 23:25:36 CDT."
             <200203060425.g264PaO00901@dirty-bastard.pthbb.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 06 Mar 2002 15:06:55 +1100
Message-ID: <13857.1015387615@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 05 Mar 2002 23:25:36 -0500, 
Jerrad Pierce <belg4mit@dirty-bastard.pthbb.org> wrote:
>Well I managed to switch the console to the 8x9 font which gave 42 lines of
>spew... No mention of tulip this time, at least not in what was visible.
>Also none of these ever get logged to messages so ksymoops wouldn't help?

Use a serial console (Documentation/serial-console.txt) and capture the
oops output on the second machine.

