Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281771AbRKZP3W>; Mon, 26 Nov 2001 10:29:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281835AbRKZP3G>; Mon, 26 Nov 2001 10:29:06 -0500
Received: from mx2out.umbc.edu ([130.85.253.52]:56030 "EHLO mx2out.umbc.edu")
	by vger.kernel.org with ESMTP id <S281793AbRKZP1v>;
	Mon, 26 Nov 2001 10:27:51 -0500
Date: Mon, 26 Nov 2001 10:27:49 -0500
From: John Jasen <jjasen1@umbc.edu>
X-X-Sender: <jjasen1@irix2.gl.umbc.edu>
To: Martin Knoblauch <Martin.Knoblauch@TeraPort.de>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Kernel Releases
In-Reply-To: <3C021D87.E0390883@TeraPort.de>
Message-ID: <Pine.SGI.4.31L.02.0111261025070.12817978-100000@irix2.gl.umbc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Nov 2001, Martin Knoblauch wrote:

>  The point being made (I believe) is that recently the "released"
> kernels have had a low quality with showstopper-quality bugs being
> introduced, but not detected,  very late in the -preX cycle. What the
> initiator of this thread wants is a longer testing of the last -preX
> version. And changes between that an the "release" confined to bug/doc
> fixing *only*. Whether this has to be under the "-rcX" label, or not -
> the idea behind it is sound.

I tend to agree with the idea of a -rcX labeling for -pre trees that the
maintainer thinks are 'pretty much ready'. But, it is up to the
maintainers of the relevant trees to accept such an idea, and be willing
to hold off on new and exciting patches while testing and bugstomping is
going on.

--
-- John E. Jasen (jjasen1@umbc.edu)
-- In theory, theory and practise are the same. In practise, they aren't.

