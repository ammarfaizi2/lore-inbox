Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932213AbVL3PTJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932213AbVL3PTJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 10:19:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932214AbVL3PTJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 10:19:09 -0500
Received: from c-67-177-35-222.hsd1.ut.comcast.net ([67.177.35.222]:58527 "EHLO
	ns1.utah-nac.org") by vger.kernel.org with ESMTP id S932213AbVL3PTI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 10:19:08 -0500
Message-ID: <43B549FB.1050503@wolfmountaingroup.com>
Date: Fri, 30 Dec 2005 07:53:47 -0700
From: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bernd Petrovitsch <bernd@firmix.at>
Cc: Linus Torvalds <torvalds@osdl.org>, Dave Jones <davej@redhat.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: userspace breakage
References: <Pine.LNX.4.64.0512281111080.14098@g5.osdl.org>	 <1135798495.2935.29.camel@laptopd505.fenrus.org>	 <Pine.LNX.4.64.0512281300220.14098@g5.osdl.org>	 <20051228212313.GA4388@elte.hu> <20051228214845.GA7859@elte.hu>	 <20051228201150.b6cfca14.akpm@osdl.org> <20051229073259.GA20177@elte.hu>	 <Pine.LNX.4.64.0512290923420.14098@g5.osdl.org>	 <20051229202852.GE12056@redhat.com>	 <Pine.LNX.4.64.0512291240490.3298@g5.osdl.org>	 <20051229224103.GF12056@redhat.com>	 <43B453CA.9090005@wolfmountaingroup.com>	 <Pine.LNX.4.64.0512291541420.3298@g5.osdl.org>	 <43B46078.1080805@wolfmountaingroup.com> <1135941548.3342.22.camel@gimli.at.home>
In-Reply-To: <1135941548.3342.22.camel@gimli.at.home>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernd Petrovitsch wrote:

>On Thu, 2005-12-29 at 15:17 -0700, Jeff V. Merkey wrote:
>[...]
>  
>
>>Start caring. People spend lots of money supporting you, and what you 
>>are doing. How about taking some
>>responsibility for that so they don't change their minds and move back 
>>to windows or pull their support because it's too
>>costly or too much of a hassle to produce something stable from these 
>>releases. If you export functions from the kernel,
>>    
>>
>
>The "program a driver once, runs on every windows in the future" is
>actually a myth. Talk to developers with windows drivers ....
>It is just that the companies absolutely don't have a choice if MSFT
>changes something ....
>
>	Bernd
>  
>
I support and write FS drivers for windows.   The same driver works on 
2002, 2002, 2003, and XP.  Longhorn have changed two IFS functions
and that's it, and still loads the older fs drivers through a compat 
interface.

Jeff
