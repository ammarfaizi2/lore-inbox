Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288964AbSAIStq>; Wed, 9 Jan 2002 13:49:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288960AbSAIStg>; Wed, 9 Jan 2002 13:49:36 -0500
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:45981
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S284933AbSAISt2>; Wed, 9 Jan 2002 13:49:28 -0500
Date: Wed, 9 Jan 2002 11:49:21 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Greg KH <greg@kroah.com>
Cc: Torrey Hoffman <torrey.hoffman@myrio.com>, linux-kernel@vger.kernel.org
Subject: Re: initramfs programs (was [RFC] klibc requirements)
Message-ID: <20020109184921.GR13931@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <D52B19A7284D32459CF20D579C4B0C0211CB21@mail0.myrio.com> <20020109182817.GA21494@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020109182817.GA21494@kroah.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2002 at 10:28:17AM -0800, Greg KH wrote:
> On Wed, Jan 09, 2002 at 09:54:28AM -0800, Torrey Hoffman wrote:
> > - lilo
> 
> lilo?  Am I missing something, or why would you want to run lilo running
> before the rest of your kernel has started up?

He's talking about an installer, for presumably x86, embedded hw.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
