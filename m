Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293394AbSBYMvm>; Mon, 25 Feb 2002 07:51:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293395AbSBYMvd>; Mon, 25 Feb 2002 07:51:33 -0500
Received: from ns.suse.de ([213.95.15.193]:18704 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S293394AbSBYMvY>;
	Mon, 25 Feb 2002 07:51:24 -0500
Date: Mon, 25 Feb 2002 13:50:52 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Diego Calleja <DiegoCG@teleline.es>
Cc: linux-kernel@vger.kernel.org, hpa@transmeta.com
Subject: Re: 2.4.18rc4aa1
Message-ID: <20020225135052.F3137@inspiron.suse.de>
In-Reply-To: <20020224165531.A14179@dualathlon.random> <20020224222531.04f44502.DiegoCG@teleline.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020224222531.04f44502.DiegoCG@teleline.es>
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 24, 2002 at 10:25:31PM +0100, Diego Calleja wrote:
> On Sun, 24 Feb 2002 16:55:31 +0100
> Andrea Arcangeli <andrea@suse.de> wrote:
> 
> > URL:
> > 
> > 	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.18rc4aa1.gz
> > 	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.18rc4aa1/
> 
> 
> Andrea, I think there's an error on compressed files.
> -2 times downloaded .gz file(1'3 MB?)= unexpected end of file 
> -1 time downloaded .bz2 file: Compressed file ends unexpectedly

I guess one mirror gone wild, CC'ed to Peter just in case he knows. (I
upload to the staging area, and then an atomic move will make the inode
visible in /pub, so it shouldn't a problem triggered during the upload
stage and a wget on the above url worked for me infact)

(ah, an of course remeber to use binary ftp download :)

Andrea
