Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261821AbTILSfe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 14:35:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261810AbTILSd5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 14:33:57 -0400
Received: from fed1mtao04.cox.net ([68.6.19.241]:33748 "EHLO
	fed1mtao04.cox.net") by vger.kernel.org with ESMTP id S261809AbTILSdE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 14:33:04 -0400
Message-ID: <3F621165.8040207@cox.net>
Date: Fri, 12 Sep 2003 11:33:09 -0700
From: "Kevin P. Fleming" <kpfleming@cox.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test5 _IOR/_IOW changes are breaking userspace
References: <3F620E7B.4090706@cox.net>
In-Reply-To: <3F620E7B.4090706@cox.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kevin P. Fleming wrote:

> The worst part is that the 
> changes required to get the apps to compile are incompatible with all 
> previous kernel headers.
> 

It seems I overreacted here a bit, mea culpa...

It may just be that the new headers are enforcing proper usage, and 
that the applications that won't compile are actually broken. I did 
not originally suspect this given the provenance of the applications I 
was dealing with, but I guess everyone makes mistakes, myself included :-)

