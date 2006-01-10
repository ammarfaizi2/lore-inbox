Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932092AbWAJIWw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932092AbWAJIWw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 03:22:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932093AbWAJIWw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 03:22:52 -0500
Received: from smtp.enter.net ([216.193.128.24]:52745 "EHLO smtp.enter.net")
	by vger.kernel.org with ESMTP id S932092AbWAJIWv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 03:22:51 -0500
From: "D. Hazelton" <dhazelton@enter.net>
To: Denis Vlasenko <vda@ilport.com.ua>
Subject: Re: Why the DOS has many ntfs read and write driver,but the linux can't for a long time
Date: Tue, 10 Jan 2006 03:33:56 -0500
User-Agent: KMail/1.8.1
Cc: Andrew Morton <akpm@osdl.org>, Yaroslav Rastrigin <yarick@it-territory.ru>,
       andersen@codepoet.org, linux-kernel@vger.kernel.org
References: <174467f50601082354y7ca871c7k@mail.gmail.com> <20060109231313.2d455d5f.akpm@osdl.org> <200601100933.48022.vda@ilport.com.ua>
In-Reply-To: <200601100933.48022.vda@ilport.com.ua>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601100333.57301.dhazelton@enter.net>
X-Virus-Checker-Version: Enter.Net Virus Scanner 1.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 10 January 2006 02:33, Denis Vlasenko wrote:
<snip>
> Andrew, I think this is a rare (on lkml at least) case when guy
> does not want to participate in development in a Linux way
> but wants to just pay for development instead:
> "I want this <hardware> to work good under Linux. I want to pay
> up to <sum> to whoever will agree to do that. Anybody?"
>
> Do not dismiss him lightly. There are LOTS of people which aren't
> hackish at all. An order of magniture more than 'us' computer geeks.
> M$ is successful because it uses this resource.
> We may want to think how can we use it too.
>
> No, I don't think you, or someone else on this list can efficiently
> use it, but distros, being more commercially oriented, maybe can.

This is true. The types of bounties I have seen in OS development do not 
usually reach much beyond $500. If distro's were to get behind this and start 
offering bounties of large sums for _working_ code for hardware there might 
be a response. As you've said, M$ is successful because it can throw money at 
the problems. Sadly, another reason why M$ is successful are their NDA's and 
the terms of any number of the contracts they offer hardware vendors and the 
like. (And yet another reason is the fact that they got their foot in the doo 
at just the right time. However, IMHO (and I have seen this recently), Now is 
the time for Linux to start really stepping up to bat. I have had any number 
of freinds and relatives ask me if there is an alternative to Windows and how 
it takes so much work to keep running (I teach them basic windows maintenance 
so I don't have to spend weekends going from house to house fixing problems) 
- sadly I've had to tell them they are stuck with Windows for various 
reasons. (Nothing to do with the Kernel, but the state of the available 
software))

But if the larger distro vendors would start offering bounties, all the 
various small kernel problems that would stymie them would probably 
disappear. Then the only problem is the market penetration and the 
availability of software many people have come to depend on. (I have two 
relatives who rely on the newest Yahoo IM clients voice chat and web-cam 
abilities. Yahoo has not, and apparently will not, update their "Official" 
client for Linux to have these capabilities and none of the alternative 
clients have them.) When (I'm quite hopeful) Linux begins to get more market 
penetration these problems of software should start to disappear.

_That_ is a goal Linux is (hopefully) aiming towards. This one persons offer 
of money isn't enough - but more than likely larger offered sums will lure 
more of the "Less Hackish" developers to start doing work for Linux. The 
other problem is one of the legality of binary-only modules. I, personally, 
have seen _very_ few with any "binary only" code that directly accesses 
kernel facilities - those interfaces are always released openly. (I cannot 
verify this for the two binary only modules I have had to deal with recently 
- if just because I don't actually have the time to disassemble the object 
files they ship to check for kernel function use. (Which would mean inclusion 
of portions of the Kernel Headers. Which, I'm afraid, to me would signify 
them being derivative works and therefore in violation of the GPL.)

I've wasted enough bandwidth here. Note that all flames will be read and 
laughed at :)

D. Hazelton
