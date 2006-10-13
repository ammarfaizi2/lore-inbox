Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751811AbWJMS7w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751811AbWJMS7w (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 14:59:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751812AbWJMS7w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 14:59:52 -0400
Received: from bay0-omc1-s35.bay0.hotmail.com ([65.54.246.107]:22111 "EHLO
	bay0-omc1-s35.bay0.hotmail.com") by vger.kernel.org with ESMTP
	id S1751811AbWJMS7v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 14:59:51 -0400
Message-ID: <BAY20-F8BFE6FB1EB53A9364234ED80A0@phx.gbl>
X-Originating-IP: [80.178.105.199]
X-Originating-Email: [yan_952@hotmail.com]
In-Reply-To: <1160756702.14815.1.camel@laptopd505.fenrus.org>
From: "Burman Yan" <yan_952@hotmail.com>
To: arjan@infradead.org
Cc: davej@redhat.com, jesper.juhl@gmail.com, linux-kernel@vger.kernel.org,
       pazke@donpac.ru
Subject: Re: [PATCH] HP mobile data protection system driver
Date: Fri, 13 Oct 2006 20:59:47 +0200
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 13 Oct 2006 18:59:51.0336 (UTC) FILETIME=[C30DB280:01C6EEF9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




>From: Arjan van de Ven <arjan@infradead.org>
>To: Burman Yan <yan_952@hotmail.com>
>CC: davej@redhat.com, jesper.juhl@gmail.com, linux-kernel@vger.kernel.org,  
>pazke@donpac.ru
>Subject: Re: [PATCH] HP mobile data protection system driver
>Date: Fri, 13 Oct 2006 18:25:02 +0200
>
>
>well.... breaking stuff for no reason other than "but it sounds like HIS
>name" is I thing bad. Yes the name is unfortunate, but if you can use
>the interface... why not? Just because the name isn't perfect everyone
>should change over, including keeping compatibility mess etc etc?
>That needs a stronger reason than "it sounds like his name" to me...
>
>Now if the interface itself isn't good enough, that's a different matter
>of course; but from what I read so far that's not really the case.
>

Well, I just tested hdapsd with mdps and it works - need a relatively high 
threshold, since at the
recommended 15 it tries to park heads if you simply lift the laptop. But 
regarding mouse/keyboard activity
detection, hdapsd simply right out "open failed" kind of messages and keeps 
on working.

I guess it may be a good idea after all to change the sysfs file it to hdaps 
for now.

Yan

_________________________________________________________________
Express yourself instantly with MSN Messenger! Download today it's FREE! 
http://messenger.msn.click-url.com/go/onm00200471ave/direct/01/

