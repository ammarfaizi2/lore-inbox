Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261502AbSKBXWJ>; Sat, 2 Nov 2002 18:22:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261501AbSKBXWJ>; Sat, 2 Nov 2002 18:22:09 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:14089 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261502AbSKBXWH>;
	Sat, 2 Nov 2002 18:22:07 -0500
Date: Sat, 2 Nov 2002 23:28:36 +0000
From: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
To: Patrick Finnegan <pat@purdueriots.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kconfig (qt) -> Gconfig (gtk)
Message-ID: <20021102232836.GD731@gallifrey>
References: <1036274342.16803.27.camel@irongate.swansea.linux.org.uk> <Pine.LNX.4.44.0211021652470.16432-100000@ibm-ps850.purdueriots.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211021652470.16432-100000@ibm-ps850.purdueriots.com>
User-Agent: Mutt/1.4i
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/2.4.18 (i686)
X-Uptime: 23:20:20 up 11:37,  1 user,  load average: 0.00, 0.02, 0.22
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Patrick Finnegan (pat@purdueriots.com) wrote:
> On 2 Nov 2002, Alan Cox wrote:
> 
> > On Sat, 2002-11-02 at 20:36, Dr. David Alan Gilbert wrote:
> > > Oh please....
> > > Wouldn't it be more helpful to iron the (few) small glitches out of the
> > > qt based one than write a new one just because you don't happen to like
> > > the library?
> >
> > Lota of installations have gtk but don't have qt.
> 
> And a lot of installations have QT but not GTK... This feels like a vi vs
> emacs discussion.
> 
> Personally, it makes no difference to me which library is used.  I'm
> doubtful I'll use anything other than menuconfig unless it makes my life a
> *whole* lot easier. I'd say 'choose one and get on with it.'

Exactly my point.  I just don't see the point in spending the neuron
hours on both.

But you guys who are worried about space and dependencies always can:
   1) use menuconfig
	 2) Write one in Tcl/Tk which is nice and small and portable and has
	 few dependencies......oh we've been there.

Dave
 ---------------- Have a happy GNU millennium! ----------------------   
/ Dr. David Alan Gilbert    | Running GNU/Linux on Alpha,68K| Happy  \ 
\ gro.gilbert @ treblig.org | MIPS,x86,ARM, SPARC and HP-PA | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
