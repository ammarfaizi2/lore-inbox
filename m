Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315794AbSETGIF>; Mon, 20 May 2002 02:08:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315797AbSETGIE>; Mon, 20 May 2002 02:08:04 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:49681 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S315794AbSETGIE>;
	Mon, 20 May 2002 02:08:04 -0400
Date: Sun, 19 May 2002 23:07:26 -0700
From: Greg KH <greg@kroah.com>
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
        linux-kernel@vger.kernel.org,
        kernel-janitor-discuss@lists.sourceforge.net
Subject: Re: [BKPATCH] USB: Re: AUDIT of 2.5.15 copy_to/from_user
Message-ID: <20020520060726.GC22098@kroah.com>
In-Reply-To: <E179IA6-0002eQ-00@wagner.rustcorp.com.au> <20020518225535.GA4101@conectiva.com.br> <20020518235418.GB4164@conectiva.com.br> <20020519001915.GA4279@conectiva.com.br> <20020519011601.GD4279@conectiva.com.br> <20020519013808.GF4279@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Mon, 22 Apr 2002 04:55:33 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 18, 2002 at 10:38:08PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Sat, May 18, 2002 at 10:16:01PM -0300, Arnaldo C. Melo escreveu:
> > 4th heads up:
> > 
> > USB will be on its way to Linus in some minutes, I already talked with Greg :)
> 
> Linus, Greg,
> 
> 	Please consider pulling from:
> 
> http://kernel-acme.bkbits.net:8080/usb-copy_tofrom_user-2.5

Looks good, and it looks like Linus already pulled this.

Thanks for fixing this up for the USB (and other subsystems.)

greg k-h
