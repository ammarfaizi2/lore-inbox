Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932482AbWBBXsc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932482AbWBBXsc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 18:48:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932483AbWBBXsc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 18:48:32 -0500
Received: from wproxy.gmail.com ([64.233.184.200]:42654 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932482AbWBBXsb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 18:48:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nGzxjQeH7Nw6OsgVqMd9+xuZ8axqIcHqlC85ZDPdLs/WR+FrNEIlFl8T9javEtgzOf3yUyl42Unmh6eVS112kKACr+u2tWVCueJkXR6ABvHyFCIbOXS7ct9A06dHZ06d0T7N3p5W6sL/eXIaXQPTrAFVE6eOCfdGDby1zTfYYiI=
Message-ID: <6bffcb0e0602021548r26164f91i@mail.gmail.com>
Date: Fri, 3 Feb 2006 00:48:29 +0100
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.16-rc1-mm3
Cc: nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org
In-Reply-To: <20060202142041.6222e846.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060124232406.50abccd1.akpm@osdl.org>
	 <43D7A047.3070004@yahoo.com.au>
	 <6bffcb0e0601261102j7e0a5d5av@mail.gmail.com>
	 <43D92754.4090007@yahoo.com.au> <43D927F6.9080807@yahoo.com.au>
	 <6bffcb0e0601270211v787f91d2r@mail.gmail.com>
	 <43E0718F.1020604@yahoo.com.au>
	 <20060201005106.35ca4b8c.akpm@osdl.org>
	 <6bffcb0e0602021306l6b6c1423r@mail.gmail.com>
	 <20060202142041.6222e846.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/02/06, Andrew Morton <akpm@osdl.org> wrote:
>
> I actually meant `l *0xb0161cdd' so we get file-n-line.  But from that, it
> appears that we won't get very interesting info anyway.
>
> Oh well, let's see if this still happens in next -mm.  Bugs like this have
> a habit of simply vanishing as people fix stuff up.
>

I have been using -mm4 for five days (with Nick's patch) and I didn't
notice this bug.

Regards,
Michal Piotrowski
