Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315963AbSEGUS0>; Tue, 7 May 2002 16:18:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315964AbSEGUSZ>; Tue, 7 May 2002 16:18:25 -0400
Received: from ns.suse.de ([213.95.15.193]:26885 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S315963AbSEGUSZ>;
	Tue, 7 May 2002 16:18:25 -0400
Date: Tue, 7 May 2002 22:18:25 +0200
From: Dave Jones <davej@suse.de>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.14-dj1: misc.o: undefined reference to `__io_virt_debug'
Message-ID: <20020507221824.F12134@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Adrian Bunk <bunk@fs.tum.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20020507205523.D12134@suse.de> <Pine.NEB.4.44.0205072137260.9347-100000@mimas.fachschaften.tu-muenchen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 07, 2002 at 09:44:41PM +0200, Adrian Bunk wrote:
 > > I always build my test kernels with CONFIG_DEBUG_IOVIRT=y, and I
 > > haven't seen this happen.
 > But you build without CONFIG_MULTIQUAD?

Ah, I can reproduce it now. I'll have a poke at it..

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
