Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313060AbSEVL00>; Wed, 22 May 2002 07:26:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313070AbSEVL0Z>; Wed, 22 May 2002 07:26:25 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:40977 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S313060AbSEVL0Y>; Wed, 22 May 2002 07:26:24 -0400
Date: Wed, 22 May 2002 12:26:17 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: "David S. Miller" <davem@redhat.com>, paulus@samba.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.17 /dev/ports
Message-ID: <20020522122617.B16934@flint.arm.linux.org.uk>
In-Reply-To: <Pine.LNX.4.44.0205202211040.949-100000@home.transmeta.com> <3CEB5F75.4000009@evision-ventures.com> <15595.30247.263661.42035@argo.ozlabs.ibm.com> <20020522.035435.68675894.davem@redhat.com> <3CEB6F31.2000301@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2002 at 12:13:05PM +0200, Martin Dalecki wrote:
> And now I'm just eagerly awaiting the first clueless
> l^Huser lurking on this list, who will flame me as usuall...
> But that's no problem - I got already used to it :-).

I'm waiting on Phil Blundell to notice - I think /dev/port may get used
on ARM to emulate inb() and outb() from userspace; I don't look after
glibc so shrug.

I agree however that /dev/port is a rotten interface that needs to go.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

