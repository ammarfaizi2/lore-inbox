Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262911AbSJ1HCB>; Mon, 28 Oct 2002 02:02:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262912AbSJ1HCB>; Mon, 28 Oct 2002 02:02:01 -0500
Received: from pimout1-ext.prodigy.net ([207.115.63.77]:10236 "EHLO
	pimout1-ext.prodigy.net") by vger.kernel.org with ESMTP
	id <S262911AbSJ1HCB> convert rfc822-to-8bit; Mon, 28 Oct 2002 02:02:01 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
Reply-To: landley@trommello.org
To: Skip Ford <skip.ford@verizon.net>
Subject: Re: Crunch time continues: the merge candidate list v1.1
Date: Sun, 27 Oct 2002 21:08:05 -0500
User-Agent: KMail/1.4.3
Cc: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
References: <200210202303.46848.landley@trommello.org> <200210271731.29640.landley@trommello.org> <200210280550.g9S5o9i3001282@pool-141-150-241-241.delv.east.verizon.net>
In-Reply-To: <200210280550.g9S5o9i3001282@pool-141-150-241-241.delv.east.verizon.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210272008.05280.landley@trommello.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 27 October 2002 23:50, Skip Ford wrote:
> Rob Landley wrote:
> > On Sunday 27 October 2002 19:29, Rusty Russell wrote:
> > > I think I'll keep my own list, thanks.
> >
> > Sure thing.
>
> How about not duplicating Rusty's list.

The "huge disorganized heap 'o patches" thing was an attempt to get Rusty to 
post some kind of description or announcement for the patches (and I believe 
has been in the last three or four versions unchanged), but if those either 
aren't being pushed for 2.5, or he wants to do it himself and doesn't want 
them to be on my list, I'm fine with that...

> The way you have the Kprobes
> stuff listed for example could disuade Linus from including it.  Only
> the base kprobe patch was submitted, the rest were posted out of
> kindness for those of us playing with it.

The IBM guys asked me to put kprobes on my list.  The relationship between 
kprobes and dprobes is something I had to ask about two or three times before 
getting particularly clear on (since I don't use it), and what I have links 
to is what they told me.

> I'd hate to see the number
> of patches work against it (especially since I requested the extra
> patches.)

I have yet to see Linus complain that a change has been been broken into too 
many pieces for him. :)

Rob

-- 
http://penguicon.sf.net - Terry Pratchett, Eric Raymond, Pete Abrams, Illiad, 
CmdrTaco, liquid nitrogen ice cream, and caffienated jello.  Well why not?
