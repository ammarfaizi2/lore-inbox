Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262107AbVADUbJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262107AbVADUbJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 15:31:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262134AbVADU3N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 15:29:13 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:55987 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S262129AbVADU1U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 15:27:20 -0500
Message-Id: <200501042024.j04KOH1G013921@laptop11.inf.utfsm.cl>
To: Felipe Alfaro Solana <lkml@mac.com>
cc: Rik van Riel <riel@redhat.com>, Adrian Bunk <bunk@stusta.de>,
       Willy Tarreau <willy@w.ods.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       William Lee Irwin III <wli@holomorphy.com>,
       William Lee Irwin III <wli@debian.org>, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>,
       Andries Brouwer <aebr@win.tue.nl>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Maciej Soltysiak <solt2@dns.toxicfilms.tv>
Subject: Re: starting with 2.7 
In-Reply-To: Message from Felipe Alfaro Solana <lkml@mac.com> 
   of "Tue, 04 Jan 2005 13:59:51 BST." <85546E06-5E50-11D9-A816-000D9352858E@mac.com> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 15)
Date: Tue, 04 Jan 2005 17:24:16 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Felipe Alfaro Solana <lkml@mac.com> said:
> On 4 Jan 2005, at 13:36, Rik van Riel wrote:
> > On Tue, 4 Jan 2005, Felipe Alfaro Solana wrote:
> >> I don't pretend that kernel interfaces stay written in stone, for 
> >> ages. What I would like is that, at least, those interfaces were 
> >> stable enough, let's say for a few months for a stable kernel series, 
> >> so I don't have to keep bothering my propietary VMWare vendor to fix 
> >> the problems for me, since the
> >
> > How much work are you willing to do to make this happen ? ;)
> 
> As much as needed :-)
> 
> > It would be easy enough for you to take 2.6.9 and add only
> > security fixes and critical bugfixes to it for the next 6
> > months - that would give your binary vendors a stable
> > source base to work with...
> 
> I would... if it was easy enough to find some form of a security 
> patches pool.

The work Rik mentioned is exactly to select only security/critical fixes,
and adapt them to the kernel you are handling.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
