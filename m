Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270818AbTGUXL1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 19:11:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270821AbTGUXL0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 19:11:26 -0400
Received: from voicecomcorp.com ([161.58.223.92]:8211 "EHLO voicecomcorp.com")
	by vger.kernel.org with ESMTP id S270818AbTGUXKu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 19:10:50 -0400
Message-ID: <3F1C75F4.5070804@voicecomcorp.com>
Date: Mon, 21 Jul 2003 18:23:32 -0500
From: Josh Crawley <josh@voicecomcorp.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: en
MIME-Version: 1.0
To: Joseph Fannin <jhf@rivenstone.net>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Synaptics touchpad problem.....
References: <3F1C2752.40503@voicecomcorp.com> <20030721184100.GA684@rivenstone.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joseph Fannin wrote:

>On Mon, Jul 21, 2003 at 12:48:02PM -0500, Josh Crawley wrote:
>  
>
>>Summation of cut: Compaq 1260 Touchpad does not work with Synaptics
>>    
>>
>    Boot with psmouse=noext or (better) set up the userspace half of
>the new synaptics touchpad driver for XFree86 from:
>http://w1.894.telia.com/~u89404340/touchpad/index.html
>  
>
I'll probably stick with the kernel param. I'm not the best of coders 
 (and no where near kernel-level). Course, that's why I'm here.

Still, I was wondering why it (synaptics) was putting sync errors even 
when I was in console mode. It was almost as it couldnt decode the 
output of the touchpad.

>    We're still waiting for someone to step forward and write support
>for GPM for this, I guess.
>
>  
>
I dont even have GPM on my laptop. I had enough troubles dealing with 
Slack and its incessant need of default choosing GPM.

I'm still green when it comes to understanding interals, but thanks for 
explaining what was probably a dumb question.

Josh Crawley.


