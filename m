Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751082AbWHIQaQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751082AbWHIQaQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 12:30:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751097AbWHIQaQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 12:30:16 -0400
Received: from smarthost4.mail.uk.easynet.net ([212.135.6.14]:6154 "EHLO
	smarthost4.mail.uk.easynet.net") by vger.kernel.org with ESMTP
	id S1751082AbWHIQaP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 12:30:15 -0400
Message-ID: <44DA0D93.2080307@ukonline.co.uk>
Date: Wed, 09 Aug 2006 17:30:11 +0100
From: Andrew Benton <b3nt@ukonline.co.uk>
User-Agent: Thunderbird 3.0a1 (X11/20060804)
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: ALSA problems with 2.6.18-rc3
References: <44D8F3E5.5020508@ukonline.co.uk> <1155073853.26338.112.camel@mindpipe>
In-Reply-To: <1155073853.26338.112.camel@mindpipe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
> Please try to identify the change that introduced the regression.  What
> was the last kernel/ALSA version that worked correctly?

The change happened between 2.6.17 and 2.6.18-rc1. Specifically, 
2.6.17-git4 works and 2.6.17-git5 doesn't.

Andy
