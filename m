Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264934AbSKNPhb>; Thu, 14 Nov 2002 10:37:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264936AbSKNPhb>; Thu, 14 Nov 2002 10:37:31 -0500
Received: from office.mandrakesoft.com ([195.68.114.34]:40445 "EHLO
	vador.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S264934AbSKNPha>; Thu, 14 Nov 2002 10:37:30 -0500
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Jeff Garzik <jgarzik@pobox.com>, kaos@ocs.com.au,
       Petr Vandrovec <VANDROVE@vc.cvut.cz>, linux-kernel@vger.kernel.org
Subject: Re: Modules in 2.5.47-bk...
References: <20021114042738.2091E2C080@lists.samba.org>
X-URL: <http://www.linux-mandrake.com/
Organization: MandrakeSoft
From: Thierry Vignaud <tvignaud@mandrakesoft.com>
Date: Thu, 14 Nov 2002 16:45:16 +0100
In-Reply-To: <20021114042738.2091E2C080@lists.samba.org> (Rusty Russell's
 message of "Thu, 14 Nov 2002 16:22:10 +1100")
Message-ID: <m2bs4si29f.fsf@vador.mandrakesoft.com>
User-Agent: Gnus/5.090007 (Oort Gnus v0.07) Emacs/21.2.92
 (i386-mandrake-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell <rusty@rustcorp.com.au> writes:

> > The backward compat thing is really a hack, and not system
> > software done right :( modutils should not need to rename all its
> > binaries *.old -- and have that be the default that users see when
> > installing the rpm.  No company worth its shareholders would
> > release a package full of "*.old" binaries.  Come on...
> 
> OK, would calling it "*-2.4" or something help?

most distros come with some alternative system (at lest, debian, mdk &
rh), so this problem can legally be left to vendors.

