Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267743AbTAMBqu>; Sun, 12 Jan 2003 20:46:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267753AbTAMBqu>; Sun, 12 Jan 2003 20:46:50 -0500
Received: from holomorphy.com ([66.224.33.161]:39590 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267743AbTAMBqu>;
	Sun, 12 Jan 2003 20:46:50 -0500
Date: Sun, 12 Jan 2003 17:52:29 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Michael Kingsbury <beaker@europa.beakerware.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: any chance of 2.6.0-test*?
Message-ID: <20030113015229.GB9727@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Michael Kingsbury <beaker@europa.beakerware.net>,
	linux-kernel@vger.kernel.org
References: <20030110161012.GD2041@holomorphy.com> <Pine.LNX.4.44.0301122002480.7225-100000@europa.beakerware.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0301122002480.7225-100000@europa.beakerware.net>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, I wrote:
>> Any specific concerns/issues/wishlist items you want taken care of
>> before doing it or is it a "generalized comfort level" kind of thing?
>> Let me know, I'd be much obliged for specific directions to move in.

On Sun, Jan 12, 2003 at 08:08:42PM -0500, Michael Kingsbury wrote:
> As long as I can't unzip the latest, do a quick
> 	'make xconfig' w/o changing the defaults,
> 	 followed by
> 	'make bzImage',
> and actually get the sucker to compile, I'd say go for it.  But there's 
> still too much breakage.  And until that breakage is fixed, you won't get 
> the next wave of people (users) who are curious to poke around with it.  
> (some of us don't care to take half a day just to figure out what to do to make something compile because 
> there's problems in the source.)
> (Yes, I realize I have to customize the kernel some.  But at the very 
> least the defaults shouldn't cause it to fall flat on its face.)

Hmm, I never do this, I've been recycling my own .configs for some time.
Sounds like a valid concern, I'll give it a shot.

Bill
