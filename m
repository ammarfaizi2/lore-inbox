Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129652AbQKBVl7>; Thu, 2 Nov 2000 16:41:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129701AbQKBVlu>; Thu, 2 Nov 2000 16:41:50 -0500
Received: from Cantor.suse.de ([194.112.123.193]:25607 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129652AbQKBVlm>;
	Thu, 2 Nov 2000 16:41:42 -0500
Date: Thu, 2 Nov 2000 22:41:40 +0100
From: Andi Kleen <ak@suse.de>
To: Tim Riker <Tim@Rikers.org>
Cc: Andi Kleen <ak@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: non-gcc linux?
Message-ID: <20001102224140.A16096@gruyere.muc.suse.de>
In-Reply-To: <3A01D6D1.44BD66FE@Rikers.org> <E13rRk1-0001ut-00@the-village.bc.nu> <20001102222306.A15754@gruyere.muc.suse.de> <3A01DC47.4D48D875@Rikers.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A01DC47.4D48D875@Rikers.org>; from Tim@Rikers.org on Thu, Nov 02, 2000 at 02:27:35PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02, 2000 at 02:27:35PM -0700, Tim Riker wrote:
> #pragma is a particularly difficult problem to deal with because it is
> non macro friendly. =(

When you assume C99 it is no problem, because C99 has _Pragma()



-Andi

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
