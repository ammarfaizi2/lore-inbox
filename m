Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262856AbTDYD3H (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 23:29:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262894AbTDYD3H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 23:29:07 -0400
Received: from lakemtao02.cox.net ([68.1.17.243]:55172 "EHLO
	lakemtao02.cox.net") by vger.kernel.org with ESMTP id S262856AbTDYD3G
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 23:29:06 -0400
Message-ID: <3EA8AE49.7020705@cox.net>
Date: Thu, 24 Apr 2003 22:40:57 -0500
From: David van Hoose <davidvh@cox.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: andersen@codepoet.org
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: ALSA and 2.4.x
References: <20030424212508.GI14661@codepoet.org>
In-Reply-To: <20030424212508.GI14661@codepoet.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Andersen wrote:
> On Thu Apr 24 2003 - 08:35:48 EST, David van Hoose wrote:
> 
>>Is there a ALSA backport to 2.4.x anywhere? 
> 
> I was crazy enough to take ALSA 0.9.2 and made it into a patch vs
> 2.4.x a week or two ago.  I just prefer to have ALSA be part of
> the kernel rather than needing to compile it seperately all the
> time.  The patch, along with various other things, is included as
> part of my 2.4.21-rc1-erik kernel:
> 
>     http://codepoet.org/kernel/
> 
> This is what I am running locally, and it works for me,

Works *very* well. I now have sound. I'd recommend adding the ALSA 
documentation from 2.5.x to the patch. It is easier than trying to 
navigate through alsa-project.org for setup information. It would be 
nice if ALSA was placed into 2.4.x as soon as possible. Doesn't require 
any extra patches beyond the ones for the kernel.

Thanks for the help!
David

