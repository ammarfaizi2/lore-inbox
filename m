Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280971AbRKGUuu>; Wed, 7 Nov 2001 15:50:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280978AbRKGUuk>; Wed, 7 Nov 2001 15:50:40 -0500
Received: from grobbebol.xs4all.nl ([194.109.248.218]:36166 "EHLO
	grobbebol.xs4all.nl") by vger.kernel.org with ESMTP
	id <S280971AbRKGUue>; Wed, 7 Nov 2001 15:50:34 -0500
Date: Wed, 7 Nov 2001 20:49:46 +0000
From: "Roeland Th. Jansen" <roel@grobbebol.xs4all.nl>
To: "Todd M. Roy" <troy@holstein.com>
Cc: mhaque@haque.net, rml@tech9.net, mfedyk@matchmail.com, jimmy@mtc.dhs.org,
        linux-kernel@vger.kernel.org
Subject: Re: kernel 2.4.14 compiling fail for loop device
Message-ID: <20011107204946.B13943@grobbebol.xs4all.nl>
In-Reply-To: <E290D3DA-D26B-11D5-A0A2-00306569F1C6@haque.net> <200111071213.fA7CD7b15181@pcx4168.holstein.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <200111071213.fA7CD7b15181@pcx4168.holstein.com>; from troy@holstein.com on Wed, Nov 07, 2001 at 07:13:07AM -0500
X-OS: Linux grobbebol 2.4.13 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 07, 2001 at 07:13:07AM -0500, Todd M. Roy wrote:
> When I did, and used a looped an iso image, eventually my
> computer froze up.  Using the actual cd, it did not.  So my
> personal answer would be no.

when mounting an EFS cd on the loop it also froze. this is _without_
removing the lines. the same happens when I miunt an efs partition from
harddrive with -o loop. also crash. sometimes early. sometimes late.

-- 
Grobbebol's Home                      |  Don't give in to spammers.   -o)
http://www.xs4all.nl/~bengel          | Use your real e-mail address   /\
Linux 2.4.13 (apic) SMP 466MHz/768 MB |        on Usenet.             _\_v  
