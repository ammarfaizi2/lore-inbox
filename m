Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262328AbTKIKWh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Nov 2003 05:22:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262331AbTKIKWh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Nov 2003 05:22:37 -0500
Received: from pix-525-pool.redhat.com ([66.187.233.200]:53994 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S262328AbTKIKWf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Nov 2003 05:22:35 -0500
Date: Sun, 9 Nov 2003 11:22:27 +0100
From: Arjan van de Ven <arjanv@redhat.com>
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: Sam Ravnborg <sam@ravnborg.org>,
       Alistair J Strachan <alistair@devzero.co.uk>,
       Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Subject: Re: [RFC] KBUILD 2.5 issues/regressions
Message-ID: <20031109112227.A22580@devserv.devel.redhat.com>
References: <E1AHHny-000CwE-00.arvidjaar-mail-ru@f10.mail.ru> <20031106172333.GA1097@mars.ravnborg.org> <200311091312.56115.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200311091312.56115.arvidjaar@mail.ru>; from arvidjaar@mail.ru on Sun, Nov 09, 2003 at 01:12:56PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 09, 2003 at 01:12:56PM +0300, Andrey Borzenkov wrote:
> 
> sure. But distributor already has shipped all the modules as part of kernel 
> package. Given the number of different kernels in Mandrake currently shipping 
> yet another copy of binary modules for kernel sources would easily fill up 
> the whole CD alone.

in addition at least for the rpm's I'm working on, it's no
longer kernel-source you need or can use for building external modules
against.
