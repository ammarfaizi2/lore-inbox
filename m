Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277175AbRJDIVh>; Thu, 4 Oct 2001 04:21:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277174AbRJDIV1>; Thu, 4 Oct 2001 04:21:27 -0400
Received: from theirongiant.weebeastie.net ([203.62.148.50]:31873 "EHLO
	theirongiant.weebeastie.net") by vger.kernel.org with ESMTP
	id <S277175AbRJDIVX>; Thu, 4 Oct 2001 04:21:23 -0400
Date: Thu, 4 Oct 2001 18:21:27 +1000
From: CaT <cat@zip.com.au>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Alexander Viro <viro@math.psu.edu>, landley@trommello.org,
        drepper@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: Security question: "Text file busy" overwriting executables but not shared libraries?
Message-ID: <20011004182127.B512@zip.com.au>
In-Reply-To: <Pine.GSO.4.21.0110040004430.26177-100000@weyl.math.psu.edu> <m14rpg0w4a.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <m14rpg0w4a.fsf@frodo.biederman.org>; from ebiederm@xmission.com on Thu, Oct 04, 2001 at 12:15:01AM -0600
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 04, 2001 at 12:15:01AM -0600, Eric W. Biederman wrote:
> I have days when I'm frustrated by the size of both glibc and the
> linux kernel.  stripped both the linux kernel and glibc are comparable
> in size.  Though I think the 400KB of compressed glibc-2.1.2 is
> actually smaller than the kernel for the most part.  I have to strip
> off practically everthing to get a useable bzImage under 400KB.
> 
> So any good ideas on how to get the size of linux down?

Mind if I ask why you need a bzimage under 400kb? Just curious as I've
never had the need. (And I can see needing it less then 1.4meg - are you
trying to get a kernel AND a ramdisk on the one floppy?)

-- 
CaT        "As you can expect it's really affecting my sex life. I can't help
           it. Each time my wife initiates sex, these ejaculating hippos keep
           floating through my mind."
                - Mohd. Binatang bin Goncang, Singapore Zoological Gardens
