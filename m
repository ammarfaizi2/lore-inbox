Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129511AbRC3Asg>; Thu, 29 Mar 2001 19:48:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129638AbRC3As1>; Thu, 29 Mar 2001 19:48:27 -0500
Received: from tmhoyle.gotadsl.co.uk ([195.149.46.162]:43785 "EHLO
	mail.cvsnt.org") by vger.kernel.org with ESMTP id <S129511AbRC3AsK>;
	Thu, 29 Mar 2001 19:48:10 -0500
Message-ID: <3AC3D79D.7000503@magenta-netlogic.com>
Date: Fri, 30 Mar 2001 01:47:25 +0100
From: Tony Hoyle <tmh@magenta-netlogic.com>
Organization: Magenta Logic
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.2-ac26 i686; en-US; 0.8.1) Gecko/20010326
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: How to debug an oops?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nobody seems interested in the spinlock bugs in usb so I'm trying to 
track it down myself.  I have a copy of an oops (posted earlier) but it 
doesn't give the line number of the error, so it's impossible to find 
out where it's failing.

Will kdb be any help?  Is it a source debugger or just a glorified hex 
editor?   I need to be able to break into the kernel and single step 
through the calls to work out what is going on.

I'm really out of my depth trying to debug this, but I hate having to 
boot a UP kernel just to use usb.

Tony

--
Don't click on this sig - a cyberwoozle will eat your underwear.

tmh@magenta-netlogic.com        http://www.nothing-on.tv

