Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279243AbRJWFSi>; Tue, 23 Oct 2001 01:18:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279244AbRJWFS1>; Tue, 23 Oct 2001 01:18:27 -0400
Received: from cc361913-a.flrtn1.occa.home.com ([24.0.193.171]:36234 "EHLO
	mirai.cx") by vger.kernel.org with ESMTP id <S279243AbRJWFSY>;
	Tue, 23 Oct 2001 01:18:24 -0400
Message-ID: <3BD4FDBF.7BF7FAEE@pobox.com>
Date: Mon, 22 Oct 2001 22:18:55 -0700
From: J Sloan <jjs@pobox.com>
Organization: J S Concepts
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.13-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: drevil@warpcore.org
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.13-pre6 breaks Nvidia's kernel module
In-Reply-To: <20011022172742.B445@virtucon.warpcore.org> <E15vnuN-0003jW-00@the-village.bc.nu> <20011022203159.A20411@virtucon.warpcore.org> <20011022214324.A18888@alcove.wittsend.com> <20011022211622.B20411@virtucon.warpcore.org> <003801c15b7d$6e2e4410$01c510ac@c779218a> <20011023000826.A22123@virtucon.warpcore.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drevil@warpcore.org wrote:

> I'm not complaining about the NVidia driver here. I'm simply stating that IMHO,
> I find it odd that for years microsoft has not only retained binary
> compatability within a release of windows but API compatability.

That's simply note true, as many windows
users have pointed out to you.

> There should
> not be a change to the kernel that would require changes in the driver in a
> "stable development" release tree, it's really that simple in my perhaps
> somewhat limited view. Admittedly, this breakage (which is still in doubt) that
> might have happened did happen with a "pre" version, but I feel this response
> would have been no different even if that was not the case.

nvidia is the party who maintains the nvidia driver -
and they have stated that they do not support "pre"
kernel releases. Therefore, you ought to stick with
official releases.

(Funny, I never have that problem with my voodoo3!)

Also, you mentioned "customers" - most customers
would take a dim view of a sys admin who reboots
systems left and right to try various "pre" kernels!

You had best install the distro and leave it at that,
except of course that you keep up with updates.

cu

jjs



