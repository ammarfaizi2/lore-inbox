Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273788AbRIXOiH>; Mon, 24 Sep 2001 10:38:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273922AbRIXOiA>; Mon, 24 Sep 2001 10:38:00 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:55310 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S273788AbRIXOhq>;
	Mon, 24 Sep 2001 10:37:46 -0400
Date: Mon, 24 Sep 2001 11:37:56 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Linux VM design
In-Reply-To: <12730310183.20010924170539@port.imtp.ilyichevsk.odessa.ua>
Message-ID: <Pine.LNX.4.33L.0109241136210.19147-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Sep 2001, VDA wrote:

> RvR> http://linux-mm.org/
>
> I was there today. Good. Can this stuff be placed as
> Doc/mv/vm2.4rik
> to prevent it from being outdated in 2-3 months?

Putting documents in the kernel tree has never worked
as a means of keeping them up to date.

Unless, of course, you're volunteering to keep them
up to date ;)

> Also I'd like to be enlightened why this:
>
> >Virtual Memory Management Policy
> >--------------------------------
> >The basic principle of the Linux VM system is page aging.

> is better than plain simple LRU?
>
> We definitely need VM FAQ to have these questions answered once per VM
> design, not once per week :-)



> RvR> The only thing missing is an explanation of Andrea's
> RvR> VM, but knowing Andrea's enthusiasm at documentation
> RvR> I wouldn't really count on that any time soon ;)
>
> :-)
>
> --
> Best regards, VDA
> mailto:VDA@port.imtp.ilyichevsk.odessa.ua
>
>

Rik
-- 
IA64: a worthy successor to i860.

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

