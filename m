Return-Path: <linux-kernel-owner+w=401wt.eu-S1751308AbXAKR4M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751308AbXAKR4M (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 12:56:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751301AbXAKR4M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 12:56:12 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:7987 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751308AbXAKR4L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 12:56:11 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=P9JVy2ykCYmSR+odz39uxKK7qEXhFBtMttXH0055pUDFgNd3vYIYKvp4hqpH+urf4MMqKWoFKoe6cI7/0PeTv5oM3YzxroHcbEoQYbgy5PHMZW+wuAzsIhMVqFRDIRf6JiSz9X0rFz0MLyg4U0qsaJXPI3453GrafeJ98klcrUo=
Message-ID: <13426df10701110955y18381bbeg5f23c0e375383836@mail.gmail.com>
Date: Thu, 11 Jan 2007 10:55:18 -0700
From: "ron minnich" <rminnich@gmail.com>
To: "Mitch Bradley" <wmb@firmworks.com>
Subject: Re: [PATCH] Open Firmware device tree virtual filesystem
Cc: "OLPC Developer's List" <devel@laptop.org>,
       "Linux Kernel ML" <linux-kernel@vger.kernel.org>
In-Reply-To: <45A67987.6030508@firmworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <13426df10701110939k21f7bb1dy38d2b34ca37a5a36@mail.gmail.com>
	 <45A67987.6030508@firmworks.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/11/07, Mitch Bradley <wmb@firmworks.com> wrote:
> Segher has a modification to the devtree patch that creates a lower
> level ops vector that can be implemented with callback or non-callback.
>
> It is still being tested.

Wonderful! If the non-callback version works out, then we can greatly
widen the potential use of the OF device tree for many BIOSes. If that
works, then we can put the proprietary tables into a small box and
ignore them :-)

thanks

ron
