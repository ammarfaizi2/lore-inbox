Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262604AbVFVEIQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262604AbVFVEIQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 00:08:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262709AbVFVEIQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 00:08:16 -0400
Received: from wproxy.gmail.com ([64.233.184.204]:63566 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262604AbVFVEIE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 00:08:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=b0lNCDZ3OC8udJygLoRyHR1SA2/5SkiTbLhhhq5n4KkEbI0+dQ0AX8sAElPi3b7aRhS73mMlr39cnJrtYr79CCNeG12yrgKqQ6IUaaaT3/A2H1qbm8oFP0bFDNuuDFHTauOZVh2nFYraq5ajscRO8m1eKjzKaPDs6JO/YWD1IL8=
Message-ID: <c1e1128f0506212108243e2c3b@mail.gmail.com>
Date: Wed, 22 Jun 2005 12:08:04 +0800
From: David Teigland <dteigland@gmail.com>
Reply-To: teigland@redhat.com
To: Andrew Morton <akpm@osdl.org>
Subject: Re: -mm -> 2.6.13 merge status (configfs)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050620235458.5b437274.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050620235458.5b437274.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/21/05, Andrew Morton <akpm@osdl.org> wrote:
> git-ocfs
> 
>     The OCFS2 filesystem.  OK by me, although I'm not sure it's had enough
>     review.

Does this include configfs?  I'd especially like to see that sooner
rather than later.

Dave
