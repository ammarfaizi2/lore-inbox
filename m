Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264434AbTDXEln (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 00:41:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264435AbTDXEln
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 00:41:43 -0400
Received: from h24-70-162-27.wp.shawcable.net ([24.70.162.27]:28307 "EHLO
	ubb.apia.dhs.org") by vger.kernel.org with ESMTP id S264434AbTDXEll
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 00:41:41 -0400
From: "Tony 'Nicoya' Mantler" <nicoya@apia.dhs.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Flame Linus to a crisp!
References: <20030424041004$113a@gated-at.bofh.it>
Organization: Judean People's Front; Department of Whips, Chains, Thumb-Screws, Six Tons of Whipping Cream, the Entire Soprano Section of the Mormon Tabernacle Choir and Guest Apperances of Eva Peron aka Eric Conspiracy Secret Laboratories
X-Disclaimer-1: This message has been edited from it's original form by members of the Eric Conspiracy.
X-Disclaimer-2: There is no Eric Conspiracy.
User-Agent: MT-NewsWatcher/3.1 (PPC)
Date: Wed, 23 Apr 2003 23:53:29 -0500
Message-ID: <nicoya-632CFE.23532923042003@news.sc.shawcable.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20030424041004$113a@gated-at.bofh.it>,
 Linus Torvalds <torvalds@transmeta.com> wrote:

[...]
:   I want to make it clear that DRM is perfectly ok with Linux!
[...]

Well ok then. I assume for DRM to be in the kernel it would have to somehow be 
in a useful form, and to be in a useful form it would have to be secure. I think 
everyone can agree it does no good to have completely useless code cluttering 
the kernel.

I see two directions of signing, a bottom up (like media DRM) and a top down 
(like X-Box or TCPA).

The latter should be very easy to implement securely and doesn't really qualify 
as "DRM", but the former doesn't seem so simple.

If we assume the context of a standard PC, there would be nothing stopping a 
user from replacing his signed DRM-compliant kernel with another unsigned kernel 
which would put on a puppet show for the DRM app, pretending to be signed.

The kernel must invariably be considered untrusted client code - code which in 
this case controls every aspect of the system that a DRM app could interact 
with, allowing it 100% freedom to fool a DRM app into thinking it's operaing in 
a secure environment, or on a different computer, or on the cold side of pluto. 
There's nothing stopping it, especially with the source freely available.

Making DRM in linux sercure would be like winning a hand of poker against 
someone who can change all the playing cards at will.

How would you, or anyone, intend to address this? (besides changing the 
definition of a "standard desktop PC" to only include systems like X-Box which 
refuse to run unsigned code, and can't be overridden by the user)


Unless this is just a very silly troll?


Cheers - Tony 'Nicoya' Mantler :)

-- 
Tony "Nicoya" Mantler - Renaissance Nerd Extraordinaire - nicoya@apia.dhs.org
Winnipeg, Manitoba, Canada           --           http://nicoya.feline.pp.se/
