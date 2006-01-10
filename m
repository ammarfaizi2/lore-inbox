Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750783AbWAJMjQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750783AbWAJMjQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 07:39:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750799AbWAJMjQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 07:39:16 -0500
Received: from gromit.trivadis.com ([193.73.126.130]:22225 "EHLO
	lttit.trivadis.com") by vger.kernel.org with ESMTP id S1750783AbWAJMjQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 07:39:16 -0500
Message-ID: <43C3AAE2.1090900@cubic.ch>
Date: Tue, 10 Jan 2006 13:38:58 +0100
From: Tim Tassonis <timtas@cubic.ch>
User-Agent: Thunderbird 1.5 (X11/20051025)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: State of the Union: Wireless
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> I don't like the idea of maintaining two of anything. What if I have two 
> wireless interfaces, each using a different stack?
> 
> Performance--,
> Kernel size++
> 
> I get that it's hard to get everyone to agree on one stack or another, but we 
> need to make the decision now because the longer we don't have a decision 
> made (this includes maintaining two in-tree stacks) the longer it's going to 
> take us to have serious / robust / reliable / consistent wireless support.

This is exactly the opposite of what Linus proposes in his management 
style document: "Avoid making decisions". At the moment, nobody seems to 
know what the "right" direction is, because the right direction is the 
one that will produce the better wireless support, and not the one that 
sounds better at the moment.

I therefore also vote for merging both stacks.

> We can always undo mistakes later, but 
> we'll never get to that point if we don't start moving in one direction 
> instead of ten.

You were right if there were ten, but there seem to be only two at the 
moment. One stack will survive and one will die. There's no point in 
deciding this now.

Tim


