Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262164AbTLLXJN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 18:09:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262228AbTLLXJN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 18:09:13 -0500
Received: from mail.gmx.de ([213.165.64.20]:7352 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262164AbTLLXJG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 18:09:06 -0500
Date: Sat, 13 Dec 2003 00:09:05 +0100 (MET)
From: "Svetoslav Slavtchev" <svetljo@gmx.de>
To: William Park <opengeometry@yahoo.ca>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
References: <20031212224520.GA1082@node1.opengeometry.net>
Subject: Re: Multiple keyboard/monitor vs linux-2.6?
X-Priority: 3 (Normal)
X-Authenticated: #20183004
Message-ID: <2641.1071270545@www59.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, Dec 12, 2003 at 11:27:48PM +0100, Svetoslav Slavtchev wrote:
> > Hi,
> > 
> > it does work, and you even can have multiple 
> > virtual consoles, and even on a single dual headed
> > Matrox G4xx/G550 although there are still some 
> > small/big :-)  issues 
> > 
> > may i ask what do you mean by that :
> > 
> > ----
> >  Even though the HOWTO is more for Backstreet Ruby, 
> >  I couldn't make head or tail of it.
> >  ^^^^^^^^^^^^^^^^^^^^^^^^
> > ----
> > 
> > asking cause i wrote the howto,
> > and i hardly get feedback
> > 
> > the one thing i know is, that it's simply too big ,
> > but i tried to cover everything and there is no other way :(
> > 
> > best,
> > 
> > svetljo
> 
> 
> For kernel-2.6.x, Ruby would be the only option.  

not really, there was a ? one liner ? fix
to make the kernel ignore usb keyboards
so you can still use Miguel's solution

>So, I'll eventually
> get my teeth into it.  But, I don't want to modify both kernel and X,
> especially kernel.  If X doesn't work, I can use the old X.  But, if
> kernel doesn't work, then I have to reboot.

if you just want muliple X users bruby/ ruby should work as stable as 2.4
/2.6 
(works at least for 20-25 people i helped, reading the howto and getting it
up),

but if you want multiple virtual terminals, you'll have to experiment :-)
and read a lot the linuxconsole ml, as it's not yet documented 

i really don't see what's the problem with installing XFree, 
it's just another 2mb binary, and it has better stability for most 
video cards, there are some that don't need it, so
it's up to you to decide " go for the stable solution or experiment"

> > 
> > 
> > PS.
> > 
> > please CC me as i'm not subscribed to lkml
> 
> If you're not subscribed, how did you post to the mailing-list?
> 

just send a mail to linux-kernel (at) vger.kernel.org,
you don't have to be subscribed to post to lkml
/* thanks god */

best,

svetljo


-- 
+++ GMX - die erste Adresse für Mail, Message, More +++
Neu: Preissenkung für MMS und FreeMMS! http://www.gmx.net


