Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317181AbSILUGK>; Thu, 12 Sep 2002 16:06:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317182AbSILUGK>; Thu, 12 Sep 2002 16:06:10 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:39172 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317181AbSILUGJ>; Thu, 12 Sep 2002 16:06:09 -0400
Date: Thu, 12 Sep 2002 21:10:56 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: [OFFTOPIC] Spamcop
Message-ID: <20020912211056.J4739@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'd like to bring to peoples attention the idiotic situation going on
with the RBL list known as spamcop.

spamcop have entered into their database the IP address for
www.linux.org.uk, which is a machine containing many mailing lists
and other facilities.  www.linux.org.uk is NOT, repeat NOT an open
relay, and as far as I'm aware has never performed any open relaying.

However, the basis under which it has been listed is that spamcop
received a mailman reponse to a message their tester sent to a valid
mailing list address.  The mailman response was:

"Subject: Your message to Linux-arm awaits moderator approval"

Obviously, it didn't relay the spam, nor the test message.


If spamcop is accepting hosts with mailing lists that send responses
back to the person sending the original mail, any mailing list is open
to being listed in the spamcop database.

My advice is: stay FAR away from spamcop.  If you're using spamcop
on your mail server, remove it now before they cut you off from all
your mailing lists.

Here's the URL explaining why www.linux.org.uk has been listed:

   http://spamcop.net/w3m?action=checkblock&ip=195.92.249.252

(Note: this does mean that some kernel people may not be able to
post messages for a while.  Hence the vague relevance of this
message to lkml.)

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

