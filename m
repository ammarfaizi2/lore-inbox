Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964771AbWGMBhh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964771AbWGMBhh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 21:37:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932490AbWGMBhh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 21:37:37 -0400
Received: from nz-out-0102.google.com ([64.233.162.205]:40821 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932489AbWGMBhh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 21:37:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:reply-to:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id:from;
        b=YmY0GVeOz1LNHa7TgnbH73S9f/UCpCs9tRDjlQWwpBc0ermNxgm6d8ZrKVsMTJTNMgzWxgSfjtGRRenSVh3xpJUcC1a0438h8oSjhR0P4u1goZhzM3LiDU7cxw69V0rHotB6eHbEvNfvx8fgeE+LPQYwGCA7QdnyB7byVcdZk0s=
Reply-To: ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [2.6 patch] let CONFIG_SECCOMP default to n
Date: Wed, 12 Jul 2006 21:37:27 -0400
User-Agent: KMail/1.9.1
Cc: andrea@cpushare.com, Lee Revell <rlrevell@joe-job.com>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, Andrew Morton <akpm@osdl.org>,
       bunk@stusta.de, linux-kernel@vger.kernel.org
References: <20060629192121.GC19712@stusta.de> <200607111619.37607.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com> <20060712211358.GA10811@elte.hu>
In-Reply-To: <20060712211358.GA10811@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607122137.29738.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
From: Andrew James Wade <andrew.j.wade@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 12 July 2006 17:13, Ingo Molnar wrote:
...
> actually, the client side of ptrace isnt all that more complex.

Ah. I'm out of my depth here. 

Andrew Wade
