Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263816AbRFLXWq>; Tue, 12 Jun 2001 19:22:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263834AbRFLXWg>; Tue, 12 Jun 2001 19:22:36 -0400
Received: from maynard.mail.mindspring.net ([207.69.200.243]:26420 "EHLO
	maynard.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S263825AbRFLXWS>; Tue, 12 Jun 2001 19:22:18 -0400
Subject: Re: Getting A Patch Into The Kernel
From: Robert Love <rml@tech9.net>
To: craigl@promise.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <005101c0f38f$e2000960$bd01a8c0@promise.com>
In-Reply-To: <005101c0f38f$e2000960$bd01a8c0@promise.com>
Content-Type: text/plain
X-Mailer: Evolution/0.10 (Preview Release)
Date: 12 Jun 2001 19:21:50 -0400
Message-Id: <992388112.5004.0.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, this is the correct forum.  You can submit the patch here.  Merely
paste the patch output inline into your email, and make your subject
"[PATCH] 2.4.5 FastTrak RAID Whatever Fix" and explain in the email.

Note your code must become GPL licensed.

I would suggest making the patch against the latest kernel, 2.4.5 -- or
even better, 2.4.5-ac13 or 2.4.6-pre2.

I suggest reading linux/Documentation/SubmittingPatches for coding
standards, etc.

It is good to see manufactures supporting their products in Linux, thank
you!

-- 
Robert M. Love
rml@ufl.edu
rml@tech9.net

On 12 Jun 2001 15:34:43 -0700, Craig Lyons wrote:
> Hello,
> 
> My name is Craig Lyons and I am the marketing manager at Promise Technology.
> We have a question and are hoping you can point us in the right direction.
> In the 2.4 kernel there is support for some of our products (Ultra 66, Ultra
> 100, etc.). As you may or may not know, our Ultra family of controllers
> (which are just standard IDE controllers and do not have RAID) use the same
> ASIC on them as our FastTrak RAID controllers do. The 2.4 kernel will
> recognize our Ultra family of controllers, but there is a problem in that a
> FastTrak will not be recognized as a FastTrak, but as an Ultra.
> Consequently, the array on the FastTrak is not recognized as an array, but
> instead each disk is seen individually, and the users data cannot be
> properly accessed. We have a patch that fixes this and are wondering if it
> is possible to get this patch into the kernel, and if so, how this would be
> done?
> 
> I apologize if this is the incorrect e-mail to be making this request to. If
> this is not the correct address to be posting this message, any assistance
> as to where it should be directed would be greatly appreciated.
> 
> Regards,
> 
> Craig

