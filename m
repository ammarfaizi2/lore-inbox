Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129524AbQLREbs>; Sun, 17 Dec 2000 23:31:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130599AbQLREb3>; Sun, 17 Dec 2000 23:31:29 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:56329 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S129524AbQLREbS>; Sun, 17 Dec 2000 23:31:18 -0500
Date: Sun, 17 Dec 2000 21:58:32 -0600
To: ferret@phonewave.net
Cc: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        Petr Vandrovec <VANDROVE@vc.cvut.cz>,
        Dana Lacoste <dana.lacoste@peregrine.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [OT] Re: Linus's include file strategy redux
Message-ID: <20001217215831.V3199@cadcamlab.org>
In-Reply-To: <14908.29798.413845.663365@wire.cadcamlab.org> <Pine.LNX.3.96.1001217120047.29402A-100000@tarot.mentasm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.3.96.1001217120047.29402A-100000@tarot.mentasm.org>; from ferret@phonewave.net on Sun, Dec 17, 2000 at 12:08:35PM -0800
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[ferret@phonewave.net]
> One last question: WHY is the kernel's top-level Makefile handling
> this symlink?

Where do you think it should be handled?  'make modules_install' seems
like the most logical place, to me.

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
