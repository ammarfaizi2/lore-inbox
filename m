Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265879AbSKBFbI>; Sat, 2 Nov 2002 00:31:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265881AbSKBFbI>; Sat, 2 Nov 2002 00:31:08 -0500
Received: from modemcable077.18-202-24.mtl.mc.videotron.ca ([24.202.18.77]:23314
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S265879AbSKBFbH>; Sat, 2 Nov 2002 00:31:07 -0500
Date: Sat, 2 Nov 2002 00:36:48 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Bill Davidsen <davidsen@tmr.com>
cc: Steven King <sxking@qwest.net>, Linus Torvalds <torvalds@transmeta.com>,
       Joel Becker <Joel.Becker@oracle.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Chris Friesen <cfriesen@nortelnetworks.com>,
       "Matt D. Robinson" <yakker@aparity.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <lkcd-general@lists.sourceforge.net>,
       <lkcd-devel@lists.sourceforge.net>
Subject: Re: What's left over.
In-Reply-To: <Pine.LNX.3.96.1021102000343.29692C-100000@gatekeeper.tmr.com>
Message-ID: <Pine.LNX.4.44.0211020033310.14075-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Nov 2002, Bill Davidsen wrote:

>   The thing is that Solaris, AIX, and ISC are written by commercial
> companies, they realize that customers need to be able to debug systems
> which don't have a screen, a serial printer, etc. They do have disk. 
> 
>   I was hoping Alan would push Redhat to put this in their Linux so we
> could resolve some of the ongoing problems which don't write an oops to a
> log, but I guess none of the developers has to actually support production
> servers and find out why they crash.

Perhaps i'm being grossly naive here, but none of these presumably x86 
productions servers don't have a serial port? Not even PCI/ISA slots to 
add one? Serial would catch most of your oopsen anyway, and if you were 
borked enough that serial couldn't get the entire output, i somehow doubt 
dumping to disk could manage. And no i don't see anything wrong nor 
consider it studly to use oopses only for debugging...

	Zwane

-- 
function.linuxpower.ca

