Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278732AbRJZP51>; Fri, 26 Oct 2001 11:57:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278727AbRJZP5Q>; Fri, 26 Oct 2001 11:57:16 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:18576
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S278675AbRJZP5N>; Fri, 26 Oct 2001 11:57:13 -0400
Date: Fri, 26 Oct 2001 08:57:40 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Manik Raina <manik@cisco.com>
Cc: linux-kernel@vger.kernel.org, azu@sysgo.de
Subject: Re: [PATCH] : preventing multiple includes of the same header file
Message-ID: <20011026085740.D6439@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <Pine.GSO.4.33.0110231618100.29108-100000@cbin2-view1.cisco.com> <20011023080936.A13088@cpe-24-221-152-185.az.sprintbbd.net> <3BD9867D.382CCC36@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BD9867D.382CCC36@cisco.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2001 at 09:21:25PM +0530, Manik Raina wrote:
> > I've changed _PPC_xxx_H to _ASM_xxx_H to match the rest of the headers.
> > This is now in the PPC bk tree, and will eventually hit Linus' tree,
> > thanks!
> >
> 
> Would point your kind attention towards some others files in the same
> directory
> (include/asm-ppc) which dont follow _PPC_XXX_H convention either.....

They'll get cleaned up eventually.  Thanks for pointing 'em out.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
