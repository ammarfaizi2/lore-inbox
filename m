Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261461AbTCGJpG>; Fri, 7 Mar 2003 04:45:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261460AbTCGJpG>; Fri, 7 Mar 2003 04:45:06 -0500
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:3601 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S261461AbTCGJpE>; Fri, 7 Mar 2003 04:45:04 -0500
Date: Fri, 7 Mar 2003 10:55:27 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: "H. Peter Anvin" <hpa@zytor.com>
cc: Greg KH <greg@kroah.com>, Linus Torvalds <torvalds@transmeta.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCH] klibc for 2.5.64 - try 2
In-Reply-To: <3E67F76E.4050709@zytor.com>
Message-ID: <Pine.LNX.4.44.0303071051410.5042-100000@serv>
References: <20030307001655.GB13766@kroah.com> <Pine.LNX.4.44.0303070156430.32518-100000@serv>
 <3E67F03F.2070902@zytor.com> <Pine.LNX.4.44.0303070215490.32518-100000@serv>
 <3E67F76E.4050709@zytor.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 6 Mar 2003, H. Peter Anvin wrote:

> > Why would it be awkward? libgcc has the same problem, so they added this 
> > paragraph:
> > 
> > In addition to the permissions in the GNU General Public License, the
> > Free Software Foundation gives you unlimited permission to link the
> > compiled version of this file into combinations with other programs,
> > and to distribute those combinations without any restriction coming
> > from the use of this file.  (The General Public License restrictions
> > do apply in other respects; for example, they cover modification of
> > the file, and distribution when not linked into a combine
> > executable.)
> > 
> > Why can't we do something similiar?
> 
> Why does it matter?

You are avoiding my question. If something goes into the kernel, the 
kernel license would be the obvious choice. Granting additional rights or 
using a dual license is a relatively small problem. But you must certainly 
have a reason to choose a completely different license?

bye, Roman

