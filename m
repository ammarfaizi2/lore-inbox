Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261160AbUBTLFy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 06:05:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261158AbUBTLFy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 06:05:54 -0500
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:22988 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261160AbUBTLFx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 06:05:53 -0500
Date: Fri, 20 Feb 2004 03:06:49 -0800
To: linux-kernel@vger.kernel.org
Subject: Re: Hot kernel change
Message-ID: <20040220110649.GA24361@hockwold.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <12608.62.229.71.110.1077197623.squirrel@webmail.r3pek.homelinux.org> <Pine.LNX.4.53.0402190845440.30037@chaos> <20040219200449.GC5916@hockwold.net> <30562.62.229.71.110.1077222343.squirrel@webmail.r3pek.homelinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <30562.62.229.71.110.1077222343.squirrel@webmail.r3pek.homelinux.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Jim Richardson <warlock@eskimo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 19, 2004 at 08:25:43PM -0000, Carlos Silva wrote:

<snip>


>well, that's what i had in mind... if this could be possible under x86
>would be great. i say x86 'cause for what a read, MkLinux looks like a
>MacLinux Distribution, correct me if i am wrong.
>like i said in the first place, i don't program for the kernel (yet, i
>intend to), so i don't know what are the big/small changes that have to be
>made for somthing like this to work. but i would really like to see this
>working :D

MkLinux was available for x86, but I have no idea if it is still in
development. To be clear, it doesn't allow you to simply replace a
kernel, but to add a second one, and possibly, to start transferring
over tasks to it. 

You can do much the same thing with user mode linux also. Again, not a
kernel replacement in that sense, but something similar, sort of. 


-- 
Jim Richardson     http://www.eskimo.com/~warlock
RFC 882 put the dot in .com.
