Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263039AbVAFVnu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263039AbVAFVnu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 16:43:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263017AbVAFVmD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 16:42:03 -0500
Received: from out011pub.verizon.net ([206.46.170.135]:16561 "EHLO
	out011.verizon.net") by vger.kernel.org with ESMTP id S263001AbVAFVjk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 16:39:40 -0500
Message-ID: <41DDB02C.1030205@cwazy.co.uk>
Date: Thu, 06 Jan 2005 16:39:56 -0500
From: Jim Nelson <james4765@cwazy.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: Norbert van Nobelen <Norbert@edusupport.nl>,
       Raphael Jacquot <raphael.jacquot@imag.fr>, linux-kernel@vger.kernel.org
Subject: Re: Open hardware wireless cards
References: <20050105200526.GL5159@ruslug.rutgers.edu>	 <20050106172438.GT5159@ruslug.rutgers.edu> <41DD8D71.7000708@imag.fr>	 <200501062032.13513.Norbert@edusupport.nl> <1105045205.15823.4.camel@krustophenia.net>
In-Reply-To: <1105045205.15823.4.camel@krustophenia.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH at out011.verizon.net from [209.158.220.243] at Thu, 6 Jan 2005 15:39:36 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
> On Thu, 2005-01-06 at 20:32 +0100, Norbert van Nobelen wrote:
> 
>>100mWatt antenna (-: Gives 4 mile range (-:
>>Make it USB powered (-: (so that the pcmcia card does not overheat!!)
> 
> 
> Ah, this reminds me, isn't there some kind of issue with open source
> wireless and FCC (or whatever your local equivalent is) regulations?  Or
> was that just an excuse the vendors used for their closed source
> drivers?
> 
> Lee
> 

A little of both, methinks.  Most vendors build their hardware to the most 
powerful that any law (or engineering limits) will allow.  They then use 
country-specific drivers to keep tha hardware operating within legal limits.

Open-source drivers would make it trivial to make the hardware operate beyond its 
legal limits - and could potentially land them in trouble with the FCC/whatever. 
IANAL, but I'm pretty sure that there hasn't been a case of open-source wireless 
drivers tweaked beyond the legal limits landing someone with a fine.
