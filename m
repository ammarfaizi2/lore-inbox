Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268032AbUHEWXG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268032AbUHEWXG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 18:23:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267984AbUHEWUu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 18:20:50 -0400
Received: from the-village.bc.nu ([81.2.110.252]:24255 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268008AbUHEWLP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 18:11:15 -0400
Subject: Re: Linux 2.6.8-rc3 - BSD licensing
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <yw1xisbxfere.fsf@kth.se>
References: <Xine.LNX.4.44.0408041156310.9291-100000@dhcp83-76.boston.redhat.com>
	 <1091644663.21675.51.camel@ghanima>
	 <Pine.LNX.4.58.0408041146070.24588@ppc970.osdl.org>
	 <1091647612.24215.12.camel@ghanima>
	 <Pine.LNX.4.58.0408041251060.24588@ppc970.osdl.org>
	 <411228FF.485E4D07@users.sourceforge.net>
	 <Pine.LNX.4.58.0408050941590.24588@ppc970.osdl.org>
	 <yw1x7jsdh42d.fsf@kth.se> <1091737280.8366.1.camel@localhost.localdomain>
	 <yw1xisbxfere.fsf@kth.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Message-Id: <1091740124.8364.41.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 05 Aug 2004 22:08:48 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-08-05 at 22:37, Måns Rullgård wrote:
> > The random driver has an example of that kind of dual licensing made
> > explicit. Given code gets modified for the kernel maybe it would be
> > simpler to just give the URL of the original in the comments so everyone
> > else (who probably wants the original anyway) can grab it there.
> 
> That doesn't make it any nicer to replace one license with another
> without the author's permission.  Adding an explicit GPL is fine, the
> BSD license allows that.  However, it also requires that the original
> license remain in place.

The random driver says...

/*
 * random.c -- A strong random number generator
 *
 * Version 1.89, last modified 19-Sep-99
 *
 * Copyright Theodore Ts'o, 1994, 1995, 1996, 1997, 1998, 1999.  All
 * rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * 1. Redistributions of source code must retain the above copyright
 *    notice, and the entire permission notice in its entirety,
 *    including the disclaimer of warranties.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in
the
 *    documentation and/or other materials provided with the
distribution.
 * 3. The name of the author may not be used to endorse or promote
 *    products derived from this software without specific prior
 *    written permission.
 *
 * ALTERNATIVELY, this product may be distributed under the terms of
 * the GNU General Public License, in which case the provisions of the
GPL are
 * required INSTEAD OF the above restrictions.  (This clause is
 * necessary due to a potential bad interaction between the GPL and
 * the restrictions contained in a BSD-style copyright.)
 *
 * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
 * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
 * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE, ALL OF
 * WHICH ARE HEREBY DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR BE
 * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT
 * OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
 * BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
 * USE OF THIS SOFTWARE, EVEN IF NOT ADVISED OF THE POSSIBILITY OF SUCH
 * DAMAGE.
 */
 

