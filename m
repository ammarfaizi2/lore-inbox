Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264581AbTLEXZs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 18:25:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264594AbTLEXZs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 18:25:48 -0500
Received: from stinkfoot.org ([65.75.25.34]:53386 "EHLO stinkfoot.org")
	by vger.kernel.org with ESMTP id S264581AbTLEXZr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 18:25:47 -0500
Message-ID: <3FD114A5.5070100@stinkfoot.org>
Date: Fri, 05 Dec 2003 18:28:37 -0500
From: Ethan Weinstein <lists@stinkfoot.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6a) Gecko/20031103
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Rusell \"Elik\" Rademacher" <elik@webspires.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: HT apparently not detected properly on 2.4.23
References: <20031203235837.GW8039@holomorphy.com> <Pine.LNX.4.44.0312051511440.5412-100000@logos.cnet> <20031205174850.GE8039@holomorphy.com> <17783749062.20031205110751@webspires.com> <3FD0CD65.5080307@stinkfoot.org> <86101410218.20031205160213@webspires.com>
In-Reply-To: <86101410218.20031205160213@webspires.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell "Elik" Rademacher wrote:
> Hello Ethan,
> 
>    Seems that patch of yours finally did the job of reporting it right this time around.  I had to gank a few servers of different versions and giving the webhosting customers some little inconvience of downtime of 3 to 10 minutes for the linux recompile and reboot.  And they all finally reports the number of processors correctly as it should be.
> 
>    Thanks Ethan.  I going to put it on more servers that got those and see how they all go as well.  As for the servers, they are all usually ServerWorks, Intel Chipsets of various types with Intel E1000, E100, Realtek network ports and with 3Ware or SCSI Adaptec adapters.  Got about 80 of them in various types to go though, but 5 of them I that tested it on, it all reports correctly.
> 
>    Let see if the Dell servers also report the same as well when I get though with them tonight.
> 

Glad to help, but don't credit me with that patch, it was courtesy of 
William Irwin.


-E
