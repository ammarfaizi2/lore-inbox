Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261234AbUC3VR3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 16:17:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261246AbUC3VR3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 16:17:29 -0500
Received: from moutng.kundenserver.de ([212.227.126.176]:21698 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261234AbUC3VRZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 16:17:25 -0500
From: Hans-Peter Jansen <hpj@urpla.net>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: VMware-workstation-4.5.1 on linux-2.6.4-x86_64 host fai
Date: Tue, 30 Mar 2004 22:17:19 +0100
User-Agent: KMail/1.5.4
Cc: Petr Vandrovec <VANDROVE@vc.cvut.cz>, linux-kernel@vger.kernel.org
References: <19772436779@vcnet.vc.cvut.cz> <200403241955.38489.hpj@urpla.net> <20040330123331.GB461@elf.ucw.cz>
In-Reply-To: <20040330123331.GB461@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403302317.19144.hpj@urpla.net>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:18d01dd0a2a377f0376b761557b5e99a
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On Tuesday 30 March 2004 14:33, Pavel Machek wrote:
> Hi!
>
> Marking ioctl compatible when it is not is pretty nasty, right?

Yup.

> What about writing conversion functions?

FJI: It's underway through the master of x86_64: Andi Kleen.
Tests unfortunately pending..

Cheers,
Pete

