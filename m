Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290184AbSBXVmI>; Sun, 24 Feb 2002 16:42:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291397AbSBXVls>; Sun, 24 Feb 2002 16:41:48 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:52484 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S290184AbSBXVlj>; Sun, 24 Feb 2002 16:41:39 -0500
Date: Sun, 24 Feb 2002 22:41:35 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Martin Dalecki <dalecki@evision-ventures.com>,
        Troy Benjegerdes <hozer@drgw.net>,
        Linus Torvalds <torvalds@transmeta.com>,
        Andre Hedrick <andre@linuxdiskcert.org>,
        Rik van Riel <riel@conectiva.com.br>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Flash Back -- kernel 2.1.111
Message-ID: <20020224224135.B1949@ucw.cz>
In-Reply-To: <3C7956EC.5000706@evision-ventures.com> <E16f6F7-0002kv-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E16f6F7-0002kv-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Sun, Feb 24, 2002 at 09:31:37PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 24, 2002 at 09:31:37PM +0000, Alan Cox wrote:
> > (Do you remmeber about 4 years ago there *was* already a lengthy
> > discussion about bus speed detection, without any proper resolution at
> > all...I remember myself having even provided some code for this
> > purpose...which was basicually just measuring RAM transfer rates...)
> 
> I guess we register an isa and a vlb bus - anyone have two vlb busses ?

I think having two VLBs is quite impossible - they were wired right to
the CPU. Maybe in some early weird multiprocessor 486 or p5 machine?

-- 
Vojtech Pavlik
SuSE Labs
