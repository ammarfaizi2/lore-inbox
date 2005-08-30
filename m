Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751441AbVH3PrQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751441AbVH3PrQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 11:47:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751445AbVH3PrQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 11:47:16 -0400
Received: from zproxy.gmail.com ([64.233.162.197]:37269 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751440AbVH3PrP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 11:47:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SE9Vv8Ir6WpKUmehEVGVTYfykJz7eOBZeVVoCRMnBM0SRcnVxP1wvYd+JGpAjVDjzzD6vHZdT1MVpXZ9OKGGz4M3KTCQETKEnAYG+TH+DhdBMRSRHW+aZf6+Krl9uThr7bC3ccN3E73i5AlNA9oXC3mWn6WDIH4/OKSaUq1XG84=
Message-ID: <9a8748490508300847422b901f@mail.gmail.com>
Date: Tue, 30 Aug 2005 17:47:07 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: [PATCH] fix compiler warning in aic7770
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-scsi@vger.kernel.org,
       James.Bottomley@steeleye.com
In-Reply-To: <20050830145157.GB3708@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200508300115.47618.jesper.juhl@gmail.com>
	 <20050830145157.GB3708@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/30/05, Adrian Bunk <bunk@stusta.de> wrote:
> On Tue, Aug 30, 2005 at 01:15:36AM +0200, Jesper Juhl wrote:
> 
> > Fix compiler warning in drivers/scsi/aic7xxx/aic7770.c :
> >    drivers/scsi/aic7xxx/aic7770.c:129: warning: unused variable `l'
> >...
> 
> This patch is already in 2.6.13-rc6-mm2 (through the scsi-misc-2.6.git
> tree).
> 
Ok, I only checked 2.6.13. 
Thank you for the feedback.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
