Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263583AbREYGe3>; Fri, 25 May 2001 02:34:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263580AbREYGeV>; Fri, 25 May 2001 02:34:21 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:51874 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S263583AbREYGeI>;
	Fri, 25 May 2001 02:34:08 -0400
Date: Fri, 25 May 2001 02:34:05 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Aaron Lehmann <aaronl@vitelus.com>
cc: "Albert D. Cahalan" <acahalan@cs.uml.edu>, adam@yggdrasil.com,
        linux-kernel@vger.kernel.org
Subject: Re: Fwd: Copyright infringement in linux/drivers/usb/serial/keyspan*fw.h
In-Reply-To: <20010524230321.B23155@vitelus.com>
Message-ID: <Pine.GSO.4.21.0105250229220.24864-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 24 May 2001, Aaron Lehmann wrote:

> explicit about defining source code:
> 	The source code for a work means the preferred form of the work for
> 	making modifications to it.

Erm... May I point you to the sysdep/libm-ieee754/e_j0.c? There's a bunch
of constants of unknown origin. If you want to modify the implementation
you most certainly want more than numeric values.

Same goes for any tables that contain anything besides well-known constants.

Should we file bug reports against glibc?

