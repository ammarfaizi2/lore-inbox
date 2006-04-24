Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751289AbWDXVYW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751289AbWDXVYW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 17:24:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751297AbWDXVYQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 17:24:16 -0400
Received: from pproxy.gmail.com ([64.233.166.176]:5822 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751290AbWDXVYD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 17:24:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=k3MK1/kyuEk4mrFpQaiDZLgD6lsQi2aHPovw21Xie0fIMj5EkXLLbF7M+eCRoXzw+hvSB2DrMhBlE0r5mLiL+6c4s5QqIIU85IkSE2kfrPRxcV3KgMiPplwv5WWTMZ5qDYdCocUDd6mlNyglgrlSlvprbkhEGmSIQYxtIXKNiPM=
Message-ID: <bda6d13a0604241423g1c6e4e4aweed8559cebcb5374@mail.gmail.com>
Date: Mon, 24 Apr 2006 14:23:57 -0700
From: "Joshua Hudson" <joshudson@gmail.com>
To: "Avi Kivity" <avi@argo.co.il>, linux-kernel@vger.kernel.org
Subject: Re: Compiling C++ modules
In-Reply-To: <444D3D32.1010104@argo.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <B9FF2DE8-2FE8-4FE1-8720-22FE7B923CF8@iomega.com>
	 <1145911546.1635.54.camel@localhost.localdomain>
	 <444D3D32.1010104@argo.co.il>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Do not meddle in the internals of kernels, for they are subtle and
quick to panic.
Ha ha. Quick to OOPS maybe, but it keeps running after that more often than not.
I've gotten a clean shutdown after null pointer exception while
holding several locks.
Thank goodness for preemptable kernel.
