Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284969AbRLQCef>; Sun, 16 Dec 2001 21:34:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284975AbRLQCe0>; Sun, 16 Dec 2001 21:34:26 -0500
Received: from ns.suse.de ([213.95.15.193]:6417 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S284969AbRLQCeL>;
	Sun, 16 Dec 2001 21:34:11 -0500
Date: Mon, 17 Dec 2001 03:33:54 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.1 - intermediate bio stuff..
In-Reply-To: <200112170221.fBH2LAx01188@vindaloo.ras.ucalgary.ca>
Message-ID: <Pine.LNX.4.33.0112170330080.29678-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Dec 2001, Richard Gooch wrote:

> # modprobe nfs
> /lib/modules/2.5.1/kernel/fs/nfs/nfs.o: unresolved symbol seq_escape
> /lib/modules/2.5.1/kernel/fs/nfs/nfs.o: unresolved symbol seq_printf

Fixed in the 2.4 forward port.

Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

