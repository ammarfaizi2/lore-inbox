Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265223AbSJWU5P>; Wed, 23 Oct 2002 16:57:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265225AbSJWU5O>; Wed, 23 Oct 2002 16:57:14 -0400
Received: from pc132.utati.net ([216.143.22.132]:31617 "HELO
	merlin.webofficenow.com") by vger.kernel.org with SMTP
	id <S265223AbSJWU5M> convert rfc822-to-8bit; Wed, 23 Oct 2002 16:57:12 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
Reply-To: landley@trommello.org
To: vamsi@in.ibm.com, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Son of crunch time: the list v1.2.
Date: Wed, 23 Oct 2002 11:03:20 -0500
User-Agent: KMail/1.4.3
Cc: Guillaume Boissiere <boissiere@adiglobal.com>,
       linux-kernel@vger.kernel.org
References: <20021021135137.2801edd2.rusty@rustcorp.com.au> <3DB4B1B9.4070303@pobox.com> <20021023155853.A28909@in.ibm.com>
In-Reply-To: <20021023155853.A28909@in.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210231103.20711.landley@trommello.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 23 October 2002 05:28, Vamsi Krishna S . wrote:

> We are not proposing the entire dprobes patch to be in kernel. It doesn't
> have to be. We are proposing for inclusion the "kprobes" patchset at
> http://www-124.ibm.com/linux/patches/?project_id=141 which provides
> the basic infrastructure in the kernel for setting up and handling
> breakpoints automatically in kernel space. Once this small piece is in,
> we can implement comprehensive tools like dynamic probes as external
> kernel modules without having to patch the kernel.

Okay, so if patch 1 is kprobes itself, what exactly is the status of patches 
2-4?  (Optional but nice?  Cleanups?  Or are you pushing as hard for them as 
for part 1?)

I thought 2-4 paved the way for dprobes, but if you're not trying to get 
dprobes in...?

Rob

-- 
http://penguicon.sf.net - Terry Pratchett, Eric Raymond, Pete Abrams, Illiad, 
CmdrTaco, liquid nitrogen ice cream, and caffienated jello.  Well why not?
