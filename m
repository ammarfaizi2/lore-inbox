Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932068AbWEFTfO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932068AbWEFTfO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 May 2006 15:35:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932070AbWEFTfO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 May 2006 15:35:14 -0400
Received: from fw5.argo.co.il ([194.90.79.130]:12560 "EHLO argo2k.argo.co.il")
	by vger.kernel.org with ESMTP id S932068AbWEFTfM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 May 2006 15:35:12 -0400
Message-ID: <445CFA6B.9030105@argo.co.il>
Date: Sat, 06 May 2006 22:35:07 +0300
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
CC: Dave Pitts <dpitts@cozx.com>, linux-kernel@vger.kernel.org
Subject: Re: How can I boost block I/O performance
References: <445CE6ED.30703@cozx.com> <9e4733910605061231v7150c69ela2968d3931523bc5@mail.gmail.com>
In-Reply-To: <9e4733910605061231v7150c69ela2968d3931523bc5@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 May 2006 19:35:10.0672 (UTC) FILETIME=[302EB500:01C67144]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Smirl wrote:
> Does the adaptive readahead patch help in your case? Other people in
> similar situations are saying that it helps a lot.
>
> Wu Fengguang
> Subject    [PATCH 00/23] Adaptive read-ahead V11
> http://lkml.org/lkml/2006/3/18/235
>
Adaptive readahead is not going to help his write performance...

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

