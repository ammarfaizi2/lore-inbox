Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265218AbUETSvH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265218AbUETSvH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 May 2004 14:51:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265219AbUETSvH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 May 2004 14:51:07 -0400
Received: from mail8.fw-bc.sony.com ([160.33.98.75]:52457 "EHLO
	mail8.fw-bc.sony.com") by vger.kernel.org with ESMTP
	id S265218AbUETSvE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 May 2004 14:51:04 -0400
Message-ID: <40ACFE39.2060901@am.sony.com>
Date: Thu, 20 May 2004 11:51:37 -0700
From: Tim Bird <tim.bird@am.sony.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: john weber <weber@sixbit.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Performance Tuning
References: <20040520120514.GA29540@sixbit.org>
In-Reply-To: <20040520120514.GA29540@sixbit.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john weber wrote:
> I've been comparing kernel compile stats online to those I get 
> on my own machine, and I am baffled.
> 
> Kernel compiles take 6m38s on my P4 2.8GHz (with HT enabled) and 
> 512 MB RAM as compared to 20-30 seconds reported by folks online. 
> I am running kernel 2.6.6.
> 
> While I understand that this varies with the config, I also don't 
> see why it should vary so much.  Does anyone have any pointers on 
> how I could best troubleshoot my performance?

I have used compiler cache, and gotten about 30-second
compiles, after the first one, on a P4 3.0GHz.

See:  http://ccache.samba.org/

However, this isn't addressing performance of your machine, per-se.

=============================
Tim Bird
Architecture Group Co-Chair
CE Linux Forum
Senior Staff Engineer
Sony Electronics
E-mail: Tim.Bird@am.sony.com
=============================

