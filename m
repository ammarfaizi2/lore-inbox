Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275685AbTHOE4Q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 00:56:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275686AbTHOE4Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 00:56:16 -0400
Received: from chromatix.demon.co.uk ([80.177.102.173]:50383 "EHLO
	lithium.chromatix.org.uk") by vger.kernel.org with ESMTP
	id S275685AbTHOE4O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 00:56:14 -0400
Date: Fri, 15 Aug 2003 05:55:50 +0100
Subject: Re: agpgart failure on KT400
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v552)
Cc: linux-kernel@vger.kernel.org
To: Greg KH <greg@kroah.com>
From: Jonathan Morton <chromi@chromatix.demon.co.uk>
In-Reply-To: <20030815044701.GA29502@kroah.com>
Message-Id: <BE0BC96C-CEDC-11D7-A88B-003065664B7C@chromatix.demon.co.uk>
Content-Transfer-Encoding: 7bit
X-Mailer: Apple Mail (2.552)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> However, I did encounter a compilation problem with one of the USB
>> device drivers - not a major problem at present since that particular
>> device is attached to a different machine - but it does show that 2.6
>> isn't ready for primetime yet.  The major distros aren't going to make
>> that switch for a while.
>
> Which device driver?
> What was the error?
> Did you report it anywhere?

OV511 - it looks like it's an "old driver, new kernel" compatibility 
thing.  I haven't reported it yet, got other things on my plate, 
including what appear to be routing loops within my ISP.

Since I know who the maintainer is, I'll probably report it directly to 
him when I get a chance.

--------------------------------------------------------------
from:     Jonathan "Chromatix" Morton
mail:     chromi@chromatix.demon.co.uk
website:  http://www.chromatix.uklinux.net/
tagline:  The key to knowledge is not to rely on people to teach you it.

