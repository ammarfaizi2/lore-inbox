Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265637AbTBFHVh>; Thu, 6 Feb 2003 02:21:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265667AbTBFHVh>; Thu, 6 Feb 2003 02:21:37 -0500
Received: from willow.compass.com.ph ([202.70.96.38]:30728 "EHLO
	willow.compass.com.ph") by vger.kernel.org with ESMTP
	id <S265637AbTBFHVg>; Thu, 6 Feb 2003 02:21:36 -0500
Subject: Re: [Linux-fbdev-devel] Re: New logo code (fwd)
From: Antonino Daplas <adaplas@pol.net>
To: Torrey Hoffman <thoffman@arnor.net>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
In-Reply-To: <1044472678.1321.388.camel@rohan.arnor.net>
References: <Pine.GSO.4.21.0302051336170.16681-100000@vervain.sonytel.be> 
	<1044472678.1321.388.camel@rohan.arnor.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1044428655.1169.19.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 05 Feb 2003 15:15:17 +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-02-06 at 03:17, Torrey Hoffman wrote:
> > > On Sun, 12 Jan 2003, Geert Uytterhoeven wrote:
> > > > The current logo code is messy, complex, and inflexible. So I decided to
> > > > rewrite it. My goals were:
> [ good list ]
> 
> This is wonderful.  I (and some co-conspirators) started a similar
> project, and put up patches at www.arnor.net/linuxlogo . But yours is up
> to date, and ours is not (I was waiting until the framebuffer rewrite
> was done, and then I didn't have time to catch up).  
> 
> It would be great if your patch was merged.  If I may offer some
> suggestions... well, feature requests :-)
> 
> It would also be nice to have an option to turn off the blinking cursor

You can control some of the attributes of the cursor in 2.5.  The
examples illustrated in linux/Documentation/VGA-Softcursor.txt should
work.  

Tony



