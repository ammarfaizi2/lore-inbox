Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290370AbSAPGge>; Wed, 16 Jan 2002 01:36:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290373AbSAPGgY>; Wed, 16 Jan 2002 01:36:24 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:63974 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S290370AbSAPGgS>;
	Wed, 16 Jan 2002 01:36:18 -0500
Date: Wed, 16 Jan 2002 01:36:12 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Peter Samuelson <peter@cadcamlab.org>
cc: "Eric S. Raymond" <esr@thyrsus.com>, Rob Landley <landley@trommello.org>,
        Nicolas Pitre <nico@cam.org>, lkml <linux-kernel@vger.kernel.org>,
        kbuild-devel@lists.sourceforge.net
Subject: Re: CML2-2.1.3 is available
In-Reply-To: <20020116062942.GC2067@cadcamlab.org>
Message-ID: <Pine.GSO.4.21.0201160135390.6091-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 16 Jan 2002, Peter Samuelson wrote:

> But the horse's mouth, in this case, is /proc/sys/kernel/real-root-dev,
> a 16-bit decimal int which represents a device number in

... and is there only if initrd is compiled in.

