Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751450AbWBQOa4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751450AbWBQOa4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 09:30:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751451AbWBQOa4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 09:30:56 -0500
Received: from mail17.syd.optusnet.com.au ([211.29.132.198]:38322 "EHLO
	mail17.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751450AbWBQOa4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 09:30:56 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] mm: implement swap prefetching (v26)
Date: Sat, 18 Feb 2006 01:30:44 +1100
User-Agent: KMail/1.9.1
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       ck list <ck@vds.kolivas.org>
References: <200602172235.40019.kernel@kolivas.org>
In-Reply-To: <200602172235.40019.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602180130.44873.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 17 February 2006 22:35, Con Kolivas wrote:
> Added disabling of swap prefetching when laptop_mode is enabled.
>
> Comment and function name cleanups etc.
>
> Please consider for -mm.

Heh I borked something rotten in this one. There I go again. Please ignore 
this request.

Cheers,
Con
