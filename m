Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316916AbSFKIHq>; Tue, 11 Jun 2002 04:07:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316919AbSFKIHp>; Tue, 11 Jun 2002 04:07:45 -0400
Received: from [195.63.194.11] ([195.63.194.11]:26895 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S316916AbSFKIHn> convert rfc822-to-8bit; Tue, 11 Jun 2002 04:07:43 -0400
Message-ID: <3D05AFCF.6000308@evision-ventures.com>
Date: Tue, 11 Jun 2002 10:07:43 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0.0) Gecko/20020611
X-Accept-Language: pl, en-us
MIME-Version: 1.0
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.21 kill warinigs 14/19
In-Reply-To: <Pine.LNX.4.33.0206082235240.4635-100000@penguin.transmeta.com> <3D049157.3040600@evision-ventures.com> <20020610204726.A681@nightmaster.csn.tu-chemnitz.de>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

U¿ytkownik Ingo Oeser napisa³:
> On Mon, Jun 10, 2002 at 01:45:27PM +0200, Martin Dalecki wrote:
> 
>>irlap_frame this time. Let me guess they used emacs?!
> 
> 
> The better way to solve this is to include:
> 
> /*
>  * Overrides for Emacs so that we follow Linus's tabbing style.
>  * Emacs will notice this stuff at the end of the file and automatically
>  * adjust the settings for this buffer only.  This must remain at the end
>  * of the file.
>  * ---------------------------------------------------------------------------
>  * Local variables:
>  * c-indent-level: 8
>  * c-brace-imaginary-offset: 0
>  * c-brace-offset: -8
>  * c-argdecl-indent: 8
>  * c-label-offset: -8
>  * c-continued-statement-offset: 8
>  * c-continued-brace-offset: 0
>  * End:
>  */
> 
> at the end of each file these people who cannot use their editor touch.
> 
> That's how I solved it with my own team mates ;-)

And it's the best way to annoy everybody who know how to use a proper
programmers editor, aka gvim, too... This is becouse it doesn't
show how to hightlight trailing white space garbage. (Hint GVIM
handles it beautifully :-)

