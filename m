Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317308AbSILVB0>; Thu, 12 Sep 2002 17:01:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317312AbSILVBZ>; Thu, 12 Sep 2002 17:01:25 -0400
Received: from h66-38-216-165.gtconnect.net ([66.38.216.165]:38404 "HELO
	innerfire.net") by vger.kernel.org with SMTP id <S317308AbSILVBY>;
	Thu, 12 Sep 2002 17:01:24 -0400
Date: Thu, 12 Sep 2002 17:06:15 -0400 (EDT)
From: Gerhard Mack <gmack@innerfire.net>
To: Russell King <rmk@arm.linux.org.uk>
cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [OFFTOPIC] Spamcop
In-Reply-To: <20020912211056.J4739@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0209121657590.27346-100000@innerfire.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Check your logs .. it looks like maybe somone was sending spoofed
requests?  Either that or somone was a total dumbass.

I wonder how hard it is to generate enough requests to get somone listed.

	Gerhard


On Thu, 12 Sep 2002, Russell King wrote:

> Date: Thu, 12 Sep 2002 21:10:56 +0100
> From: Russell King <rmk@arm.linux.org.uk>
> To: Linux Kernel List <linux-kernel@vger.kernel.org>
> Subject: [OFFTOPIC] Spamcop
>
> Hi,
>
> I'd like to bring to peoples attention the idiotic situation going on
> with the RBL list known as spamcop.
>
> spamcop have entered into their database the IP address for
> www.linux.org.uk, which is a machine containing many mailing lists
> and other facilities.  www.linux.org.uk is NOT, repeat NOT an open
> relay, and as far as I'm aware has never performed any open relaying.
>
> However, the basis under which it has been listed is that spamcop
> received a mailman reponse to a message their tester sent to a valid
> mailing list address.  The mailman response was:
>
> "Subject: Your message to Linux-arm awaits moderator approval"
>
> Obviously, it didn't relay the spam, nor the test message.
>
>
> If spamcop is accepting hosts with mailing lists that send responses
> back to the person sending the original mail, any mailing list is open
> to being listed in the spamcop database.
>
> My advice is: stay FAR away from spamcop.  If you're using spamcop
> on your mail server, remove it now before they cut you off from all
> your mailing lists.
>
> Here's the URL explaining why www.linux.org.uk has been listed:
>
>    http://spamcop.net/w3m?action=checkblock&ip=195.92.249.252
>
> (Note: this does mean that some kernel people may not be able to
> post messages for a while.  Hence the vague relevance of this
> message to lkml.)
>
>

--
Gerhard Mack

gmack@innerfire.net

<>< As a computer I find your faith in technology amusing.

