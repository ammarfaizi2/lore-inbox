Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264915AbTBYAxU>; Mon, 24 Feb 2003 19:53:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264919AbTBYAxU>; Mon, 24 Feb 2003 19:53:20 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:50172 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S264915AbTBYAxT>;
	Mon, 24 Feb 2003 19:53:19 -0500
Message-ID: <3E5AC07D.50106@us.ibm.com>
Date: Mon, 24 Feb 2003 17:01:49 -0800
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (compatible; MSIE5.5; Windows 98;
X-Accept-Language: en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: Horrible L2 cache effects from kernel compile
References: <3E5ABBC1.8050203@us.ibm.com> <20030225005922.GU10411@holomorphy.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> Your profile was upside down. I've re-sorted it.
> It probably confused people who were wondering why the numbers
> at the top of the profile were lower than the ones below them.

Thanks, Bill.  oprofile's default output is useful when you're viewing
it from the cmdline, but it looks bad in email.

-- 
Dave Hansen
haveblue@us.ibm.com

