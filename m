Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129457AbQKBVtb>; Thu, 2 Nov 2000 16:49:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129542AbQKBVtW>; Thu, 2 Nov 2000 16:49:22 -0500
Received: from ra.lineo.com ([204.246.147.10]:49060 "EHLO thor.lineo.com")
	by vger.kernel.org with ESMTP id <S129457AbQKBVtH>;
	Thu, 2 Nov 2000 16:49:07 -0500
Message-ID: <3A01DFFB.D5C3B0B@Rikers.org>
Date: Thu, 02 Nov 2000 14:43:23 -0700
From: Tim Riker <Tim@Rikers.org>
Organization: Riker Family (http://rikers.org/)
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: non-gcc linux?
In-Reply-To: <3A01D6D1.44BD66FE@Rikers.org> <E13rRk1-0001ut-00@the-village.bc.nu> <20001102222306.A15754@gruyere.muc.suse.de> <3A01DC47.4D48D875@Rikers.org> <20001102224140.A16096@gruyere.muc.suse.de>
X-MIMETrack: Serialize by Router on thor/Lineo(Release 5.0.5 |September 22, 2000) at 11/02/2000
 02:49:03 PM,
	Serialize complete at 11/02/2000 02:49:03 PM
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Excellent. I guess I really need to get a copy of the C99 spec
and dig through it.

http://webstore.ansi.org/ansidocstore/product.asp?sku=ANSI%2FISO%2FIEC+9899%2D1999

Thanx!

GCC does have a table of what's been implemented so far:

http://www.gnu.org/software/gcc/c99status.html

Which indicates gcc all ready supports this? I have not yet dug into
which pragmas though... ;-)

Andi Kleen wrote:
> 
> On Thu, Nov 02, 2000 at 02:27:35PM -0700, Tim Riker wrote:
> > #pragma is a particularly difficult problem to deal with because it is
> > non macro friendly. =(
> 
> When you assume C99 it is no problem, because C99 has _Pragma()
> 
> -Andi

-- 
Tim Riker - http://rikers.org/ - short SIGs! <g>
All I need to know I could have learned in Kindergarten
... if I'd just been paying attention.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
