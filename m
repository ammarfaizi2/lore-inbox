Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270327AbTGWNxE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 09:53:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270332AbTGWNxE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 09:53:04 -0400
Received: from voicecomcorp.com ([161.58.223.92]:64518 "EHLO voicecomcorp.com")
	by vger.kernel.org with ESMTP id S270327AbTGWNxB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 09:53:01 -0400
Message-ID: <3F1E9628.40400@voicecomcorp.com>
Date: Wed, 23 Jul 2003 09:05:28 -0500
From: Josh Crawley <josh@voicecomcorp.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: en
MIME-Version: 1.0
To: David Benfell <benfell@greybeard95a.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: touchpad doesn't work under 2.6.0-test1-ac2
References: <20030722043917.GA29802@parts-unknown.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Benfell wrote:

>Hello all,
>  
>
Hello.

>Finally decided to give a development kernel a try on an HP zt1180
>laptop.  The kernel build went smoothly and I thought all was well
>(well except I guess I've gotta figure out frame buffer support again)
>until I started X and discovered that the mouse wasn't working.
>  
>
Just a few points. First, is your input pointed at /dev/input/mouse ? 
Second, you need the userspace synaptics for touchpads, which 
unfortunately needs to be done.

>I'm guessing this list doesn't allow attachments, and I don't really
>want to splat all over everybody with the output I thought relevant,
>so I've posted it on my website:
>  
>
As long as the attachments arent big, I think it's ok. I sent here a few 
problems just like what you're talking about.

Good day,
Josh

