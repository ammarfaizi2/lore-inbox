Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030510AbVIOQRc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030510AbVIOQRc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 12:17:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030511AbVIOQRc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 12:17:32 -0400
Received: from [64.162.99.240] ([64.162.99.240]:24520 "EHLO
	spamtest2.viacore.net") by vger.kernel.org with ESMTP
	id S1030510AbVIOQRb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 12:17:31 -0400
Message-ID: <43299E59.4060103@spamtest.viacore.net>
Date: Thu, 15 Sep 2005 09:16:25 -0700
From: Joe Bob Spamtest <joebob@spamtest.viacore.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050909 Fedora/1.7.10-1.5.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: HZ question
References: <4326CAB3.6020109@compro.net>	 <2cd57c9005091321006825540@mail.gmail.com> <1126747237.13893.108.camel@mindpipe>
In-Reply-To: <1126747237.13893.108.camel@mindpipe>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
> On Wed, 2005-09-14 at 12:00 +0800, Coywolf Qi Hunt wrote:
> 
>>simply zgrep HZ= /proc/config.gz
>>on my box, I get CONFIG_HZ=1000
> 
> 
> Many distros inexplicably disable that by default.

Their rationale is that knowing the kernel .config is a security threat. 
Whatever. I'd rather have the convenience than the miniscule amount of 
security that would supposedly provide
