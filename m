Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267254AbTAHMB0>; Wed, 8 Jan 2003 07:01:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267434AbTAHMB0>; Wed, 8 Jan 2003 07:01:26 -0500
Received: from elixir.e.kth.se ([130.237.48.5]:22028 "EHLO elixir.e.kth.se")
	by vger.kernel.org with ESMTP id <S267254AbTAHMAd>;
	Wed, 8 Jan 2003 07:00:33 -0500
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: OT Naming. was: Re: Why is Nvidia given GPL'd code to use in  closed source drivers?
References: <200301081123.h08BNQiO000383@habitrail.home.fools-errant.com>
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: 08 Jan 2003 13:09:14 +0100
In-Reply-To: Hacksaw's message of "Wed, 08 Jan 2003 06:23:26 -0500"
Message-ID: <yw1xn0mbn8r9.fsf@gladiusit.e.kth.se>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Channel Islands)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hacksaw <hacksaw@hacksaw.org> writes:

> >The "GNU/Linux" vs "Linux" argument is a political one, not a practical
> >one, don't try to disguise it.
> 
> I used to agree with this, and as far as politics, I do. However, a
> practical reason to call it GNU/Linux just occurred to me: the ABI.
> 
> Linux is a kernel. It runs on a variety of platforms. You certainly
> must differentiate between a program for Linux on StrongARM and one
> for Linux on x86. To use a kernel one makes calls into it via a
> system call mechanism. In the case of the vast majority of Linux
> installations, that is done via glibc.  Not for kicks is that 'g'
> there.
> 
> A system with a linux kernel using a different API will likely have a 
> different ABI for it's programs.

The functions in glibc that you are referring to are specified by
ANSI/ISO C and POSIX standards.  If a system doesn't comply to these
it's broken.  Yes, I consider systems like MSWindows broken.  Well,
there's VMS, of course.  I'll don't know what standards it follows.

-- 
Måns Rullgård
mru@users.sf.net
