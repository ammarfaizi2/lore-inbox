Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131736AbRCXRvK>; Sat, 24 Mar 2001 12:51:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131740AbRCXRvB>; Sat, 24 Mar 2001 12:51:01 -0500
Received: from logic.net ([205.243.138.83]:6639 "HELO logic.net")
	by vger.kernel.org with SMTP id <S131736AbRCXRuu>;
	Sat, 24 Mar 2001 12:50:50 -0500
Date: Sat, 24 Mar 2001 11:50:03 -0600
From: "Edward S. Marshall" <esm@logic.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [OT] Linux Worm (fwd)
Message-ID: <20010324115003.A13622@labyrinth.local>
In-Reply-To: <Pine.LNX.4.10.10103231028250.9403-100000@innerfire.net> <m3ae6c48v4.fsf@belphigor.mcnaught.org> <01032411170201.03927@tabby>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <01032411170201.03927@tabby>; from jesse@cats-chateau.net on Sat, Mar 24, 2001 at 11:11:50AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 24, 2001 at 11:11:50AM -0600, Jesse Pollard wrote:
> Bind itself has been proven over many years. This is the first major
> problem found.

This is so blatantly incorrect as to be laughable. BIND 4 and 8 had a
long and glorious history of serious security flaws; a quick search of
the www.securityfocus.com vulnerability archives for "BIND" returns a
ton of results, ranging from root compromises to denial of service
attacks to cache poisoning problems.

> If you want a fix, get bind v9. Besides handling IP version
> 4, it also handles version 6.

I'll believe in BIND 9's safety after it's been widely deployed; with few
OS vendors actually bundling BIND 9 at this point, it's received very
little real-world attention.

> It really isn't, but the new bind may be. There is even an update
> to bind 8 that contains a fix for the problem.

Until the next design flaw produces yet-another-vulnerability?

While other packages might not be free software, I don't have the luxury
of following principles in lieu of security.

Last post from me on the subject, because this has next to nothing to do
with the Linux kernel.

-- 
Edward S. Marshall <esm@logic.net>                http://www.nyx.net/~emarshal/
-------------------------------------------------------------------------------
[                  Felix qui potuit rerum cognoscere causas.                  ]
