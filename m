Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267065AbRGYQbO>; Wed, 25 Jul 2001 12:31:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268581AbRGYQbE>; Wed, 25 Jul 2001 12:31:04 -0400
Received: from mercury.Sun.COM ([192.9.25.1]:21194 "EHLO mercury.Sun.COM")
	by vger.kernel.org with ESMTP id <S267065AbRGYQav>;
	Wed, 25 Jul 2001 12:30:51 -0400
Message-ID: <3B5EF43E.C9EAF2B1@Sun.COM>
Date: Wed, 25 Jul 2001 18:30:54 +0200
From: Julien Laganier <Julien.Laganier@Sun.COM>
Organization: Sun Microsystems
X-Mailer: Mozilla 4.76 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: David CM Weber <dweber@backbonesecurity.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: device struct
In-Reply-To: <94FD5825A793194CBF039E6673E9AFE0C017@bbserver1.backbonesecurity.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

David CM Weber wrote:
> 
> I'm looking at some old (circa v2.2.5 of the kernel) sample code,
> referring to the networking system. It refers to a structure named
> "device".  Was this replaced with something else?
> 
> On a similar note, is there a "good" way of finding this data myself?
> I've been using ctags, and this is of limited use. (Sometimes good,
> sometimes bad).
> 

Use CSCOPE, available at http://cscope.sourceforge.net
It's very usefull !

-- 
"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.
--

    Julien Laganier
     Student Intern
Sun Microsystem Laboratories
