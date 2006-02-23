Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751107AbWBWBbk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751107AbWBWBbk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 20:31:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751497AbWBWBbj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 20:31:39 -0500
Received: from smtp.osdl.org ([65.172.181.4]:63404 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751107AbWBWBbj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 20:31:39 -0500
Date: Wed, 22 Feb 2006 17:31:01 -0800
From: Andrew Morton <akpm@osdl.org>
To: Alessandro Zummo <alessandro.zummo@towertech.it>
Cc: a.zummo@towertech.it, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/11] RTC subsystem, class
Message-Id: <20060222173101.4ba9060e.akpm@osdl.org>
In-Reply-To: <20060223020952.42124378@inspiron>
References: <20060219232211.368740000@towertech.it>
	<20060219232211.628944000@towertech.it>
	<20060222141554.0f5e2aa3.akpm@osdl.org>
	<20060223020952.42124378@inspiron>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alessandro Zummo <alessandro.zummo@towertech.it> wrote:
>
>   How can I handle further updates, just repost the whole patchset
>   to lkml ?

Yes, that would be best.  Once the patches are settled down I prefer
incremental updates so we can see what changed, but at this stage in
proceedings a wholesale replacement is OK.

It would be good if you can arrange it so there are no build-breaks
anywhere in the series.


