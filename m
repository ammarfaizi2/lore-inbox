Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262874AbUDHWdY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 18:33:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262897AbUDHWdY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 18:33:24 -0400
Received: from web40504.mail.yahoo.com ([66.218.78.121]:38255 "HELO
	web40504.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262874AbUDHWdW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 18:33:22 -0400
Message-ID: <20040408223321.57722.qmail@web40504.mail.yahoo.com>
Date: Thu, 8 Apr 2004 15:33:21 -0700 (PDT)
From: Sergiy Lozovsky <serge_lozovsky@yahoo.com>
Subject: Re: kernel stack challenge
To: Martin Waitz <tali@admingilde.org>
Cc: Timothy Miller <miller@techsource.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, linux-kernel@vger.kernel.org
In-Reply-To: <20040408131116.GO27401@admingilde.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, :-)

--- Martin Waitz <tali@admingilde.org> wrote:
> hi :)
> 
> On Tue, Apr 06, 2004 at 04:17:34PM -0700, Sergiy
> Lozovsky wrote:
> > What? Give an example. I want something high
> level, so
> > Forth will not do. Sure, encapsulation is needed,
> to
> > protect kernel from pointer errors and so on.
> 
> who says that the language that's used by your
> policy administrator
> is the same as the language interpreted by the
> kernel?
> 
> let your administrator write his policy in java/lisp
> or whatever,
> but compile this policy into an easy to interpret
> and safe
> bytecode.

That will not give any benefits. LISP has internal
representation of program and data for sure
('bytecode'), but it is lists. How to unload it to
something one can move around? One of the ways -
unload it in a text form. But it exactly what initial
source code is. Parser of LISP is very small (because
syntax is simple), so producing some non standard
bytecode make no sense - source code of LISP is very
close to it's 'bytecode'.

Serge.

__________________________________
Do you Yahoo!?
Yahoo! Small Business $15K Web Design Giveaway 
http://promotions.yahoo.com/design_giveaway/
