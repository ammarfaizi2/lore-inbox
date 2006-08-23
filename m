Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965004AbWHWP5Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965004AbWHWP5Z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 11:57:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965006AbWHWP5Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 11:57:25 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:46447 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S965004AbWHWP5Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 11:57:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=iMa7QCGFyjNzefpv3Vjiu3D42AyI7DcFC95G/gzKBV3+If7m3y6zSnEC6MB1hoPCrfeX5E3AqGcGtfmS1R+d3ecK8CddiotZiUBNntfrlvBc5PBwvSTfH4gwdBIPp7h2zHX27IbgMfvS+rPQowibJBiD08D2xdEYTPlkf2xh5Nc=
Date: Wed, 23 Aug 2006 19:57:16 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Christoph Hellwig <hch@infradead.org>,
       Stephane Eranian <eranian@frankl.hpl.hp.com>,
       linux-kernel@vger.kernel.org, eranian@hpl.hp.com
Subject: Re: [PATCH 1/18] 2.6.17.9 perfmon2 patch for review: introduction
Message-ID: <20060823155715.GA5204@martell.zuzino.mipt.ru>
References: <200608230805.k7N85qo2000348@frankl.hpl.hp.com> <20060823152831.GC32725@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060823152831.GC32725@infradead.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2006 at 04:28:31PM +0100, Christoph Hellwig wrote:
> oh, and please give the patches useful subjects that descript the
> patch, e.g. this one should be just:
>
>
>     [PATCH 0/17] perfmon2: introduction
>
> (yes, it's convention to number the introduction 0 and the actual patches
>  1 to n)

Padding with zeros makes it even more useful:

	[PATCH 00/17]
	[PATCH 01/17]
		...
	[PATCH 17/17]

