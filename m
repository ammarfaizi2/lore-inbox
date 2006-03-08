Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751055AbWCHHJo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751055AbWCHHJo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 02:09:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751207AbWCHHJo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 02:09:44 -0500
Received: from wproxy.gmail.com ([64.233.184.195]:24326 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751055AbWCHHJn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 02:09:43 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BOTbq5wrp9mfepPhfiWIZo9uKl9g1qTp/m+YRclAReqNFgyfCMhOU4lscKAA9cZJL8kxjtHnESODn+QvKotM1nne74JUoJ23bS+3X0BTy5z0a0Jiakd+8oC39y0o5HPhbm1qW2/BDtdmapO5So9uvVQ4Kbl0AoGhqZGCSamG8V8=
Message-ID: <a36005b50603072309w3b622edek5c6c2e7b59d7b2d5@mail.gmail.com>
Date: Tue, 7 Mar 2006 23:09:42 -0800
From: "Ulrich Drepper" <drepper@gmail.com>
To: "Phillip Susi" <psusi@cfl.rr.com>
Subject: Re: Status of AIO
Cc: "Benjamin LaHaise" <bcrl@kvack.org>, "Dan Aloni" <da-x@monatomic.org>,
       "Linux Kernel List" <linux-kernel@vger.kernel.org>
In-Reply-To: <440CC29F.2060906@cfl.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060306062402.GA25284@localdomain>
	 <20060306211854.GM20768@kvack.org>
	 <a36005b50603061453w36f5d49cs7bac0c186aee30b3@mail.gmail.com>
	 <440CC29F.2060906@cfl.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/6/06, Phillip Susi <psusi@cfl.rr.com> wrote:
> Why do you say it is not suitable?  The kernel aio interfaces should
> work very well, especially when combined with O_DIRECT.

What has network I/O to do with O_DIRECT?  I'm talking about async network I/O.
