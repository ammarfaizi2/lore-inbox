Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263145AbRFENXk>; Tue, 5 Jun 2001 09:23:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263932AbRFENXa>; Tue, 5 Jun 2001 09:23:30 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:31236 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S263145AbRFENXS>;
	Tue, 5 Jun 2001 09:23:18 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Stephen Wille Padnos <stephenwp@adelphia.net>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Exporting new functions from kernel 2.2.14 
In-Reply-To: Your message of "Tue, 05 Jun 2001 08:54:31 MST."
             <3B1D00B7.168B52D1@adelphia.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 05 Jun 2001 23:23:11 +1000
Message-ID: <16863.991747391@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 05 Jun 2001 08:54:31 -0700, 
Stephen Wille Padnos <stephenwp@adelphia.net> wrote:
>When I add my new finctions to i386ksyms.c:
>EXPORT_SYMBOL(grab_timer_interrupt);
>EXPORT_SYMBOL(release_timer_interrupt);
>
>I get names like
>
>grab_timer_interrupt_R__ver_grab_timer_interrupt
>release_timer_interrupt_R__ver_release_timer_interrupt

Read the very last line of every message on linux-kernel.

