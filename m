Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284629AbRLIX3k>; Sun, 9 Dec 2001 18:29:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284638AbRLIX3a>; Sun, 9 Dec 2001 18:29:30 -0500
Received: from zero.tech9.net ([209.61.188.187]:34054 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S284629AbRLIX30>;
	Sun, 9 Dec 2001 18:29:26 -0500
Subject: Re: [CFT] tree-based bootmem
From: Robert Love <rml@tech9.net>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011208154021.B939@holomorphy.com>
In-Reply-To: <20011208154021.B939@holomorphy.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.0.99+cvs.2001.12.06.08.57 (Preview Release)
Date: 09 Dec 2001 18:29:26 -0500
Message-Id: <1007940570.1235.13.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2001-12-08 at 18:40, William Lee Irwin III wrote:
> I've waited a week or two for bug reports to roll in from early testers
> (including myself), and no reports have come in.
> 
> So now I humbly request the assistance of a larger userbase in testing
> the bootmem patch.

Patch successfully tested on (3) i386 machines, an SH4 machine, and a
sparc32 machine.  And on the low memory SH4 machine, the
finer-granularity of addressing is welcome.

Now, when do we see some interface changes to bootmem that take
advantage of your patch? :-)

	Robert Love

