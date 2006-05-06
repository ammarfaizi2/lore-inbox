Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750793AbWEFTb5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750793AbWEFTb5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 May 2006 15:31:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751095AbWEFTb5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 May 2006 15:31:57 -0400
Received: from nz-out-0102.google.com ([64.233.162.193]:15265 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750793AbWEFTb4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 May 2006 15:31:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Ay3tVEyWLfNh/SzXn+D9S+I03bvYhho9sB3eRM0ttWo1Nt6IvnISZSSsTT+aGYKgPjUy6cVRZlEEk8S7gfyTBvWCjn5lD291gcQ5V28vdbjGT3WUftNcnxlqX55ZVCX8u7HJ9VoppuNSs3ZL/aUbM/xFLOjkn9skJ+WxofL+tlg=
Message-ID: <9e4733910605061231v7150c69ela2968d3931523bc5@mail.gmail.com>
Date: Sat, 6 May 2006 15:31:55 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Dave Pitts" <dpitts@cozx.com>
Subject: Re: How can I boost block I/O performance
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <445CE6ED.30703@cozx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <445CE6ED.30703@cozx.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Does the adaptive readahead patch help in your case? Other people in
similar situations are saying that it helps a lot.

Wu Fengguang
Subject	[PATCH 00/23] Adaptive read-ahead V11
http://lkml.org/lkml/2006/3/18/235

I'm not sure of the status of this patch. I looked in the mm tree and
didn't see it.

--
Jon Smirl
jonsmirl@gmail.com
