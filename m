Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751187AbWDXTol@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751187AbWDXTol (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 15:44:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751188AbWDXTol
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 15:44:41 -0400
Received: from nproxy.gmail.com ([64.233.182.188]:21554 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751187AbWDXTol (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 15:44:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=kOrFaHH3bV8cS/9K8/xSJ83XPrKTgBawg/31PZDZLxEDUPWq7I6T45N3iubhAxQ9wva58dskoU1GmAJl2cq+zC8apa4Fcu4w1HBO78y3g/e3jq4rIy38lPpl/fWxqqNL7Vl+i7lk5in6EHKKsrG/T7rdRY+QNUYkd7MCItj20BI=
Date: Mon, 24 Apr 2006 23:42:02 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Gary Poppitz <poppitzg@iomega.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Compiling C++ modules
Message-ID: <20060424194202.GB6222@mipter.zuzino.mipt.ru>
References: <B9FF2DE8-2FE8-4FE1-8720-22FE7B923CF8@iomega.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B9FF2DE8-2FE8-4FE1-8720-22FE7B923CF8@iomega.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 24, 2006 at 01:16:26PM -0600, Gary Poppitz wrote:
> I have the task of porting an existing file system to Linux. This
> code is in C++ and I have noticed that the Linux kernel has
> made use of C++ keywords and other things that make it incompatible.
>
> I would be most willing to point out the areas that need adjustment
> and supply patch files to be reviewed.

Such patches will be rejected. This was discussed many times, go search
archives.

