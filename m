Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283287AbRLDT3N>; Tue, 4 Dec 2001 14:29:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283282AbRLDT1j>; Tue, 4 Dec 2001 14:27:39 -0500
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:14505
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S283311AbRLDTYk>; Tue, 4 Dec 2001 14:24:40 -0500
Date: Tue, 4 Dec 2001 12:24:37 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Stefan Smietanowski <stesmi@stesmi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [kbuild-devel] Converting the 2.5 kernel to kbuild 2.5
Message-ID: <20011204192437.GU17651@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <20011204181337.GL17651@cpe-24-221-152-185.az.sprintbbd.net> <E16BKGx-0002y5-00@the-village.bc.nu> <20011204182713.GO17651@cpe-24-221-152-185.az.sprintbbd.net> <3C0D21D8.8090509@stesmi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C0D21D8.8090509@stesmi.com>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2001 at 08:19:52PM +0100, Stefan Smietanowski wrote:
> Hi.
> 
> >But they can't install python2?  I _think_ there's src.rpms on
> >Python.org that will install as python2 even...
> 
> Usually a src.rpm installs a source, not a program :)

Compiling rpms is arguably simpiler than a kernel.  rpm --recompile
foo.src.rpm, I think even :)

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
