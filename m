Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316591AbSEUU5B>; Tue, 21 May 2002 16:57:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316594AbSEUU5A>; Tue, 21 May 2002 16:57:00 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:15531 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S316591AbSEUU47>;
	Tue, 21 May 2002 16:56:59 -0400
Date: Tue, 21 May 2002 15:56:48 -0500
From: Dave McCracken <dmccr@us.ibm.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] POSIX personality
Message-ID: <72190000.1022014608@baldur.austin.ibm.com>
In-Reply-To: <Pine.LNX.4.33.0205211349100.3073-100000@penguin.transmeta.com>
X-Mailer: Mulberry/2.2.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--On Tuesday, May 21, 2002 01:52:37 PM -0700 Linus Torvalds
<torvalds@transmeta.com> wrote:

> I don't see any reason to start using some fixed-mode semantics without 
> seeing some stronger arguments on exactly why that would be a good idea. 
> We have used up 11 of 24 bits (and more can be made available) over the 
> last five years, and there are no obvious inefficiencies that I can see.

Ok, sounds reasonable.  I'll add the bits as I go, then.

Dave McCracken

======================================================================
Dave McCracken          IBM Linux Base Kernel Team      1-512-838-3059
dmccr@us.ibm.com                                        T/L   678-3059

