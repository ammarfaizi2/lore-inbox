Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131455AbRCWUol>; Fri, 23 Mar 2001 15:44:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131446AbRCWUoY>; Fri, 23 Mar 2001 15:44:24 -0500
Received: from aslan.scsiguy.com ([63.229.232.106]:56588 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S131457AbRCWUn4>; Fri, 23 Mar 2001 15:43:56 -0500
Message-Id: <200103232043.f2NKhCs17223@aslan.scsiguy.com>
To: Matthew Costello <matthew@mp3.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: aic7xxx in 2.4.3-pre6 missing db.h 
In-Reply-To: Your message of "Thu, 22 Mar 2001 10:23:41 PST."
             <3ABA432D.271E42CB@mp3.com> 
Date: Fri, 23 Mar 2001 13:43:12 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I am trying to compile the 2.4.3-pre6 linux kernel and it is failing
>because it cannot find the "db.h" header file.

Please upgrade to the latest aic7xxx driver.  Patches are available
here:

http://people.freebsd.org/~gibbs/linux/

That code will not attempt to build the firmware unless you set your
kernel config to do so.

--
Justin
