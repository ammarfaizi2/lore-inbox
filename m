Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129485AbQK0BmV>; Sun, 26 Nov 2000 20:42:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131266AbQK0BmL>; Sun, 26 Nov 2000 20:42:11 -0500
Received: from www.ylenurme.ee ([193.40.6.1]:39421 "EHLO ylenurme.ee")
        by vger.kernel.org with ESMTP id <S129485AbQK0Blz>;
        Sun, 26 Nov 2000 20:41:55 -0500
Date: Mon, 27 Nov 2000 03:11:21 +0200 (GMT-2)
From: Elmer Joandi <elmer@ylenurme.ee>
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
cc: linux-kernel@vger.kernel.org
Subject: Re: Universal debug macros.
In-Reply-To: <200011270045.BAA13121@cave.bitwizard.nl>
Message-ID: <Pine.LNX.4.10.10011270302570.24716-100000@yle-server.ylenurme.sise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 27 Nov 2000, Rogier Wolff wrote:

> Now, how is say "Red Hat" (*) going to ship kernels? Of course they are
> going to turn off debugging. Then I'll be stuck with a non-recompiling
> user-in-trouble with a non-debugging-enabled kernel. 

Red Hat will ship two kernels. Well, they actually ship now about 4 ones
or something. So they will ship 8.

Plus they will ship a script that recompiles kernel without user crawling
in documentation.
It should be an option in linuxconf: recompile local kernel:
debug-nodebug-optimized-localized-nonmodular-server-router-workstation
which compiles and installs 2  hardware/situation optimized/configured
kernels: debug and production.
I am sure company like redhat can ship a little new linuxconf module.

Don't worry, people can make good use of multiple options.
If you provide orthogonal tools they will provide orthogonal solutions.


elmer.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
