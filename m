Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270301AbUJTJIL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270301AbUJTJIL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 05:08:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270300AbUJTJH6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 05:07:58 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:53424 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S270174AbUJTJFh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 05:05:37 -0400
Message-ID: <41762A54.5080905@pobox.com>
Date: Wed, 20 Oct 2004 05:05:24 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: maximilian attems <janitor@sternwelten.at>
CC: linux-kernel@vger.kernel.org
Subject: Re: BK kernel workflow
References: <20041020083149.GA4330@stro.at>
In-Reply-To: <20041020083149.GA4330@stro.at>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

maximilian attems wrote:
>>3) merge the patch into the topic-specific repo, using Linus's patch 
>>importing tools,
>>
>>        cd 8139too && dotest < /garz/nsmail/25_Patches
> 
> 
> where are those tools available?
> 
> they are the missing chain in Andrew's patch-scripts.


http://bktools.bkbits.net/

	Jeff


