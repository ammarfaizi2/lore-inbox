Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284176AbRLFT5k>; Thu, 6 Dec 2001 14:57:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284168AbRLFT5b>; Thu, 6 Dec 2001 14:57:31 -0500
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:48396 "EHLO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S284163AbRLFT5U>; Thu, 6 Dec 2001 14:57:20 -0500
Date: Thu, 6 Dec 2001 20:14:36 +0100
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [kbuild-devel] Converting the 2.5 kernel to kbuild 2.5
Message-ID: <20011206201436.B24176@emma1.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <stoffel@casc.com> <15375.47450.229337.322610@gargle.gargle.HOWL> <200112061851.fB6IpHE0016176@pincoya.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <200112061851.fB6IpHE0016176@pincoya.inf.utfsm.cl>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Dec 2001, Horst von Brand wrote:

> I just shudder when thinking that I'll have to learn yet another weird
> language to be able to hack on Linux... C, gcc-isms with asm() and all, a
> bit of CML1, now CML2, are OK; and now Python...

You'd need to learn CML2 perhaps, but not Python.

If you don't want to learn Python, you can think of it as an opaque
run-time system for _Eric's_ implementation of a CML2 interpreter if you
like.

If someone else did a C or Perl version, CML2 would remain the same, but
the Python run-time system could be dropped perchance.
