Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315328AbSDWUhq>; Tue, 23 Apr 2002 16:37:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315332AbSDWUhp>; Tue, 23 Apr 2002 16:37:45 -0400
Received: from [195.39.17.254] ([195.39.17.254]:13455 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S315328AbSDWUho>;
	Tue, 23 Apr 2002 16:37:44 -0400
Date: Mon, 22 Apr 2002 00:18:44 +0000
From: Pavel Machek <pavel@suse.cz>
To: Anton Altaparmakov <aia21@cantab.net>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [bk2.4 patchlet] Update NBD URL in documentation.
Message-ID: <20020422001844.I155@toy.ucw.cz>
In-Reply-To: <E16zEtE-0003IW-00@storm.christs.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
> Please apply below patch updating the URL in the NBD documentation to point
> to the project home page on sourceforge.

Thanx a lot


> Best regards,
> 
> 	Anton
> -- 
> Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
> Linux NTFS maintainer / IRC: #ntfs on irc.openprojects.net
> WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
> 
> --- nbd24.patch ---
> # This is a BitKeeper generated patch for the following project:
> # Project Name: Linux kernel tree
> # This patch format is intended for GNU patch command version 2.5 or higher.
> # This patch includes the following deltas:
> #	           ChangeSet	1.419   -> 1.420  
> #	Documentation/nbd.txt	1.1     -> 1.2    
> #
> # The following is the BitKeeper ChangeSet Log
> # --------------------------------------------
> # 02/04/21	aia21@cantab.net	1.420
> # Update NBD URL.
> # --------------------------------------------
> #
> diff -Nru a/Documentation/nbd.txt b/Documentation/nbd.txt
> --- a/Documentation/nbd.txt	Sun Apr 21 11:46:16 2002
> +++ b/Documentation/nbd.txt	Sun Apr 21 11:46:16 2002
> @@ -54,4 +54,4 @@
>    ...                 in case of read operation with no error,
>                        this is immediately followed len bytes of data
>  
> -   For more information, look at http://atrey.karlin.mff.cuni.cz/~pavel.
> +   For more information, look at http://nbd.sf.net/.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

