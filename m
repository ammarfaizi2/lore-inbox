Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278121AbRJRV0M>; Thu, 18 Oct 2001 17:26:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278136AbRJRV0D>; Thu, 18 Oct 2001 17:26:03 -0400
Received: from inje.iskon.hr ([213.191.128.16]:1483 "EHLO inje.iskon.hr")
	by vger.kernel.org with ESMTP id <S278121AbRJRVZy>;
	Thu, 18 Oct 2001 17:25:54 -0400
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org, andrea@suse.de
Subject: Re: Write throughput in >= 2.4.10
In-Reply-To: <Pine.LNX.4.21.0110181735482.12429-100000@freak.distro.conectiva>
Reply-To: zlatko.calusic@iskon.hr
X-Face: s71Vs\G4I3mB$X2=P4h[aszUL\%"`1!YRYl[JGlC57kU-`kxADX}T/Bq)Q9.$fGh7lFNb.s
 i&L3xVb:q_Pr}>Eo(@kU,c:3:64cR]m@27>1tGl1):#(bs*Ip0c}N{:JGcgOXd9H'Nwm:}jLr\FZtZ
 pri/C@\,4lW<|jrq^<):Nk%Hp@G&F"r+n1@BoH
From: Zlatko Calusic <zlatko.calusic@iskon.hr>
Date: 18 Oct 2001 23:26:08 +0200
In-Reply-To: <Pine.LNX.4.21.0110181735482.12429-100000@freak.distro.conectiva> (Marcelo Tosatti's message of "Thu, 18 Oct 2001 17:36:39 -0200 (BRST)")
Message-ID: <87wv1s4p3j.fsf@atlas.iskon.hr>
User-Agent: Gnus/5.090003 (Oort Gnus v0.03) XEmacs/21.4 (Artificial Intelligence)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti <marcelo@conectiva.com.br> writes:

> On 18 Oct 2001, Zlatko Calusic wrote:
> 
> > It looks like recent kernels have some serious trouble during simple
> > writing of files. Throughput is cut to half.
> > 
[snip]

> 
> Zlatko, 
> 
> Could you please try 2.4.12-pre3 instead pre4 ?
> 
> Linus has made some changes and I want to see if those are partly
> responsible for the problems you're seeing.
> 

pre3 behaves exactly the same, so pre4 is not the culprit.
-- 
Zlatko
