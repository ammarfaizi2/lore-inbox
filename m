Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267743AbSLGKP5>; Sat, 7 Dec 2002 05:15:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267745AbSLGKP5>; Sat, 7 Dec 2002 05:15:57 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:11021 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S267743AbSLGKP4>;
	Sat, 7 Dec 2002 05:15:56 -0500
Message-ID: <3DF1CBFE.901@pobox.com>
Date: Sat, 07 Dec 2002 05:22:54 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nathaniel Russell <root@chartermi.net>
CC: reddog83@chartermi.net, linux-kernel@vger.kernel.org, davej@suse.de
Subject: Re: [PATCH 2.4.20] Via 8233 Sound Support
References: <Pine.LNX.4.44.0212070501130.1440-100000@reddog.example.net>
In-Reply-To: <Pine.LNX.4.44.0212070501130.1440-100000@reddog.example.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathaniel Russell wrote:
> Ok i agree with you it turns out my mp3's i always listen to with my
> Esoniq card dont wanna play with my Via card.
> Well it's ok. So Jeff is my patch for the Via AGP card ok to add to the
> Kernel ;) just a wounder.

I have no idea :)  Find a 3D card, and test it, making sure that AGP and 
DRM are both turned on.

Also, Dave Jones did a really nice cleanup of agpgart in 2.5, so even 
though there is no agpgart MAINTAINERS entry, I think he would be a good 
target for patches :)  Even thought 2.5 agpgart is clearly different, 
davej has a clue about it and could probably ack or apply 2.4 patches...

	Jeff



