Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266397AbUBER1Q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 12:27:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266469AbUBER1Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 12:27:16 -0500
Received: from gw-nl5.philips.com ([161.85.127.51]:49859 "EHLO
	gw-nl5.philips.com") by vger.kernel.org with ESMTP id S266397AbUBER1N
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 12:27:13 -0500
Message-ID: <40227D9D.2070704@basmevissen.nl>
Date: Thu, 05 Feb 2004 18:30:05 +0100
From: Bas Mevissen <ml@basmevissen.nl>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kyle <kyle@southa.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ICH5 with 2.6.1 very slow
References: <164601c3ec06$be8bd5a0$b8560a3d@kyle> <40227C20.80404@basmevissen.nl> <167301c3ec0d$4d8508c0$b8560a3d@kyle>
In-Reply-To: <167301c3ec0d$4d8508c0$b8560a3d@kyle>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle wrote:

> Yes they are PATA, I expect something like 40-50MB/s, now my much slower
> Celeron 1.3T with 80GB/2M perform better than my ICH5!
> 

What does 'hdparm /dev/hdX' say (X=a,b,c...)?

Bas.


