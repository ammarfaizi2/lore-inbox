Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262321AbVERQ1Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262321AbVERQ1Q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 12:27:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262352AbVERQZm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 12:25:42 -0400
Received: from rrcs-24-227-247-8.sw.biz.rr.com ([24.227.247.8]:7552 "EHLO
	emachine.austin.ammasso.com") by vger.kernel.org with ESMTP
	id S262332AbVERQXt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 12:23:49 -0400
Message-ID: <428B6BF8.2010303@ammasso.com>
Date: Wed, 18 May 2005 11:23:20 -0500
From: Timur Tabi <timur.tabi@ammasso.com>
Organization: Ammasso
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.5) Gecko/20041217 Mnenhy/0.7.2.0
X-Accept-Language: en-us, en, en-gb
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: linux.bkbits.net question: mapping cset to kernel version?
References: <428B4D14.2030104@ammasso.com> <20050518160930.GA16756@kroah.com>
In-Reply-To: <20050518160930.GA16756@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:

> But that's how you have to do it, sorry.  You have the patches, why
> can't you just use grep?  :)

What does Linus do to keep track of these changes?  Granted, he's not using BitKeeper any 
more, but it does support release management, so I would presume he was tagging the 
releases with it.  What does he do now?

-- 
Timur Tabi
Staff Software Engineer
timur.tabi@ammasso.com

One thing a Southern boy will never say is,
"I don't think duct tape will fix it."
      -- Ed Smylie, NASA engineer for Apollo 13
