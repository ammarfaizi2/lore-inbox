Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262195AbTJ3EIC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 23:08:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262196AbTJ3EIC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 23:08:02 -0500
Received: from lvs00-fl-n13.valueweb.net ([216.219.253.195]:53982 "EHLO
	ams013.ftl.affinity.com") by vger.kernel.org with ESMTP
	id S262195AbTJ3EH7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 23:07:59 -0500
Message-ID: <3FA08E5A.2090609@coyotegulch.com>
Date: Wed, 29 Oct 2003 23:06:50 -0500
From: Scott Robert Ladd <coyote@coyotegulch.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031024 Debian/1.5-2
X-Accept-Language: en
MIME-Version: 1.0
To: Alex Belits <abelits@phobos.illtel.denver.co.us>
CC: Joseph Pingenot <trelane@digitasaru.net>, Dax Kelson <dax@gurulabs.com>,
       Hans Reiser <reiser@namesys.com>, andersen@codepoet.org,
       linux-kernel@vger.kernel.org
Subject: Re: Things that Longhorn seems to be doing right
References: <3F9F7F66.9060008@namesys.com> <20031029224230.GA32463@codepoet.org> <3FA0475E.2070907@namesys.com> <1067466349.3077.274.camel@mentor.gurulabs.com> <20031030002005.GC3094@digitasaru.net> <Pine.LNX.4.58.0310291848590.11170@sm1420.belits.com>
In-Reply-To: <Pine.LNX.4.58.0310291848590.11170@sm1420.belits.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Belits wrote:
>   There is another possibility -- that the only implementation of the
> standardized indexable/searchable format that Microsoft wants to base this
> system on is a horrendous resource pig, infected with inflexible
> restrictions and requirements...

I suspect one motivation for Longhorn's file system is DRM, encoded into 
the metadata.

I don't think Hans' original message was suggesting that we clone 
Microsoft's new file system. Rather, my impression was that he was 
interested in the kind of functionality envisioned by Microsoft, and in 
pre-empting any conceptual patents Redmond might be planning.

It might be very interesting to peruse Microsoft's recent patent 
applications...

>   What most of XML-based formats certainly are. If further development
> will blindly take this road, we will lose huge amount of flexibility in
> exchange for a certain Microsoft-compatible (for a while) system of
> organizing data.

I am not fond of XML in many circumstances; it is inefficient both in 
terms of storage and processing, and is overkill for many applications. 
A files system should be mean and lean, even when it implements advanced 
features like metadata. So I think we're in agreement that Linux should 
find a better path to a similar solution.

And do it soon, before Microsoft patents the concept of a file system 
itself!

-- 
Scott Robert Ladd
Coyote Gulch Productions (http://www.coyotegulch.com)
Software Invention for High-Performance Computing

