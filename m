Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750805AbVJWWbl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750805AbVJWWbl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Oct 2005 18:31:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750811AbVJWWbl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Oct 2005 18:31:41 -0400
Received: from nproxy.gmail.com ([64.233.182.203]:12331 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750809AbVJWWbk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Oct 2005 18:31:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cFkOFrCXM7kJO5uA5/oDLpDmT5X4Cz2+KJFodmJGpu5WKezdwLY2hX/QsHPDVcpbGXVtqI6+YZgc+5qJxa8ou3n1g0jo+Eqd6oQpoorteP0nGEdJfFnOySoWYZi7a5ImQbuLP8pbP/mLYwS9HnVNFt+wv4P4PXDi237fdvPK3rM=
Message-ID: <40f323d00510231531t14b70e49wc4e67e8e9e14b613@mail.gmail.com>
Date: Mon, 24 Oct 2005 00:31:39 +0200
From: Benoit Boissinot <bboissin@gmail.com>
To: jonathan@jonmasters.org
Subject: Re: Task profiling in Linux
Cc: Claudio Scordino <cloud.of.andor@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <35fb2e590510231519u38545f2pdab36de3f7d5384@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200510232249.39236.cloud.of.andor@gmail.com>
	 <35fb2e590510231519u38545f2pdab36de3f7d5384@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/24/05, Jon Masters <jonmasters@gmail.com> wrote:
> On 10/23/05, Claudio Scordino <cloud.of.andor@gmail.com> wrote:
>
> > I need some help to make profiling of an application on Linux.
>
> Did you already try gprof?
>
or oprofile/sysprof with a recent kernel

Benoit
