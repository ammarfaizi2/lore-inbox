Return-Path: <linux-kernel-owner+w=401wt.eu-S1751409AbXAFOz0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751409AbXAFOz0 (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 09:55:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751410AbXAFOz0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 09:55:26 -0500
Received: from nf-out-0910.google.com ([64.233.182.184]:49226 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751409AbXAFOzZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 09:55:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:from;
        b=XqB8V0gqjeTF8zskUKkNXw/kVc3FcK/NR9u8A8ft8qkZRDSorLmffweHIdPk2gcKE79cpEb1h1/27P4nzHSkxqBEeslsdRnjbIMqEw/Qz30Ywb4dRSjQKs2vEjWLLvJPI4VAVvLU+3iqyZTVH+CEAky3K0pAVcLuaDVvNvqIBKs=
Date: Sat, 6 Jan 2007 16:55:03 +0200
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.20-rc3] DAC960: kmalloc->kzalloc/Casting cleanups
Message-ID: <20070106145503.GG19020@Ahmed>
Mail-Followup-To: "Robert P. J. Day" <rpjday@mindspring.com>,
	linux-kernel@vger.kernel.org
References: <20070106131725.GB19020@Ahmed> <Pine.LNX.4.64.0701060833150.12420@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0701060833150.12420@localhost.localdomain>
User-Agent: Mutt/1.5.11
From: "Ahmed S. Darwish" <darwish.07@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 06, 2007 at 08:36:23AM -0500, Robert P. J. Day wrote:
>   a couple bits of advice here.  you should start your patch
> submission with *only* that descriptive text you want included in the
> log, followed by your "Signed-off-by" line, then a line containing
> "---".
> 
>   *after* that "---" line, and *before* you start the actual patch,
> you can add superfluous text, like asking about who the maintainer is,
> so that informal dialogue like that doesn't become part of the
> permanent patch record.

> rday

Thanks for all the good notes ..

-- 
Ahmed S. Darwish
http://darwish-07.blogspot.com
