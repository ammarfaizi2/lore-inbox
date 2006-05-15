Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751528AbWEOPts@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751528AbWEOPts (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 11:49:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751513AbWEOPts
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 11:49:48 -0400
Received: from smtp12.clb.oleane.net ([213.56.31.47]:60890 "EHLO
	smtp12.clb.oleane.net") by vger.kernel.org with ESMTP
	id S1751528AbWEOPtr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 11:49:47 -0400
Message-ID: <4468A300.4090102@sej.fr>
Date: Mon, 15 May 2006 17:49:20 +0200
From: sej <sej@sej.fr>
Reply-To: sej@sej.fr
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org
Subject: Re: Rlimit
References: <6cN1B-3ky-5@gated-at.bofh.it> <6cN1B-3ky-3@gated-at.bofh.it>
In-Reply-To: <6cN1B-3ky-3@gated-at.bofh.it>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Of course !!
But if you want to increase mlock size you can't do it !
setrlimit can only decrease process limits !
I repeat my question : How to set mlock process for non-root process ?
sej



>> Hello,
>> How can I set Rlimit for 1 or more programs started in user mode (not suser) ?
>> Is there a config file or a little source that can do this ?
>> Regards,
>> sej
> 
> man setrlimit
> 
> 
> Jan Engelhardt

