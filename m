Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262469AbTIHOzL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 10:55:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262472AbTIHOzL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 10:55:11 -0400
Received: from [65.243.131.113] ([65.243.131.113]:1409 "EHLO lapdog.lund.com")
	by vger.kernel.org with ESMTP id S262469AbTIHOzC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 10:55:02 -0400
From: Scott Chapman <scott_list@mischko.com>
Reply-To: scott_list@mischko.com
To: linux-kernel@vger.kernel.org
Subject: Re: Plans for better performance metrics in upcoming kernels?
Date: Mon, 8 Sep 2003 07:54:55 -0700
User-Agent: KMail/1.5.1
References: <200309051641.44228.scott_list@mischko.com>
In-Reply-To: <200309051641.44228.scott_list@mischko.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309080754.55700.scott_list@mischko.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I received one reply to this email.  I take it there is nobody really heading 
up the implementation of improved/missing performance metrics in the kernel?

Is this on anyone's radar?

What is Linus' take on more/better metrics?  
Is he likely to roll them in if they are implemented?

Is there any plan to implement any existing patches? 

If I can get developer time applied to this project, I don't want to re-invent 
the existing pieces.  Who do I coordinate with?

Cordially,
Scott

On Friday 05 September 2003 16:41, Scott Chapman wrote:
> Hi,
> I'm wondering what the plans are for more accurate and more useful
> performance metrics in upcoming kernels.
>
> CPU Utilization by process is apparently a known-inaccuracy.
>
> There are no disk I/O metrics per process.
>
> CPU Queue Length doesn't appear to be available?
>
> Etc.
>
> Linux clearly falls behind the competition in this area. It makes it rather
> tough to do system performance analysis on a Linux box!  :-)
>
> Is there a plan to deal with these issues?  ETA's?
>
> Cordially,
> Scott

