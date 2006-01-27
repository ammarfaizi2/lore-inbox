Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932225AbWA0Ak1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932225AbWA0Ak1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 19:40:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932301AbWA0Ak1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 19:40:27 -0500
Received: from smtpout.mac.com ([17.250.248.83]:7156 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S932225AbWA0Ak0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 19:40:26 -0500
In-Reply-To: <787b0d920601261619l43bb95f5k64ddd338f377e56a@mail.gmail.com>
References: <787b0d920601241858w375a42efnc780f74b5c05e5d0@mail.gmail.com> <43D7A7F4.nailDE92K7TJI@burner> <787b0d920601251826l6a2491ccy48d22d33d1e2d3e7@mail.gmail.com> <43D8D396.nailE2X31OHFU@burner> <787b0d920601261619l43bb95f5k64ddd338f377e56a@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <B9D6BA8F-468D-46C4-B827-037A9D93F38D@mac.com>
Cc: Joerg Schilling <schilling@fokus.fraunhofer.de>, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Date: Thu, 26 Jan 2006 19:40:14 -0500
To: Albert Cahalan <acahalan@gmail.com>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 26, 2006, at 19:19, Albert Cahalan wrote:
> I may just be crazy enough to fork this project. I very nearly did  
> about 18 months ago. I can't very well do this alone, because I  
> don't have all the hardware

I will gladly test your fork on my various hardware here.  I have a  
desktop with Apple CD/RW+DVDROM and generic DVD+/-RW DL drive, and a  
laptop with Apple DVD+/-RW drive.  Just send or post patches  
somewhere and I'll take a look.  I suggest starting by looking at  
some of the various distro patches, IIRC some of them have already  
make significant cleanups.

> Matthias, can you give me a hand with this? I'll need a way to sort  
> and publish incoming patches, letting them sit for a while. (like  
> what Andrew Morton does for the kernel) This can't work like procps  
> because the hardware varies too much.

Might I suggest quilt or stgit?  Both allow you to maintain an  
unstable and highly variable stack of patches based off a more stable  
branch, from which some patches percolate down into stable occasionally.

Good luck with this!

Cheers,
Kyle Moffett

--
Simple things should be simple and complex things should be possible
   -- Alan Kay



