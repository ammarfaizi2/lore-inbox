Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277728AbRKAD5f>; Wed, 31 Oct 2001 22:57:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277782AbRKAD50>; Wed, 31 Oct 2001 22:57:26 -0500
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:58020
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S277728AbRKAD5Q>; Wed, 31 Oct 2001 22:57:16 -0500
Date: Wed, 31 Oct 2001 20:48:08 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Adam Williams <broadcast@earthling.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: crash in smp_core99_kick_cpu
Message-ID: <20011031204808.H20613@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <3BE09769.2060703@earthling.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BE09769.2060703@earthling.net>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2001 at 04:29:29PM -0800, Adam Williams wrote:

> This is a dual CPU G4.  Startup freezes after
[snip]
> Compiler gcc 2.96
> Kernel 2.4.13

Hit http://penguinppc.org/dev/kernel.shtml, and try one of those trees.
There's a few minor differences in the linuxppc_2_4 tree which might fix
this and will be in Linus' tree eventually.  And for future reference,
you might have better luck on linuxppc-dev or linuxppc-users
(http://lists.linuxppc.org)

> Kernels compiled with gcc 3.0.2 just crash and go into
> open firmware.

Known gcc 3.0.x/kernel 'feature'.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
