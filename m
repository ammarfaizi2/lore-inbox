Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278798AbRJVNgn>; Mon, 22 Oct 2001 09:36:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278802AbRJVNgd>; Mon, 22 Oct 2001 09:36:33 -0400
Received: from www.fibrespeed.net ([216.168.105.33]:25327 "HELO
	mail.fibrespeed.net") by vger.kernel.org with SMTP
	id <S278798AbRJVNgX>; Mon, 22 Oct 2001 09:36:23 -0400
Message-ID: <3BD420ED.4090508@fibrespeed.net>
Date: Mon, 22 Oct 2001 09:36:45 -0400
From: "Michael T. Babcock" <mbabcock@fibrespeed.net>
Organization: CyTech Computers
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010913
X-Accept-Language: en-us
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: VM
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > I've not reached any final conclusions on the VM - there are things that
 > Rik's VM shows up that look like the VM algorithm is right but it
 > triggers other stuff, and there are a couple of hackish bits left in 
still.

I have never done this comparison myself, but I was wondering how ugly 
it would be if stable versions of Andrea's and Rik's VMs were both 
available in your/Linus' kernel as compile-time options.  Assuming that 
each provides better performance under certain conditions, wouldn't 
being able to choose a VM make sense, if they don't step on the rest of
the kernel too much ...

-- 
Michael T. Babcock
http://www.fibrespeed.net/~mbabcock


