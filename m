Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750727AbWAENca@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750727AbWAENca (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 08:32:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751130AbWAENca
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 08:32:30 -0500
Received: from nproxy.gmail.com ([64.233.182.192]:10550 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750727AbWAENca convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 08:32:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ssbZsL7hrpI+Y8d+VFA6W0Zuv8emvDFmCMeuTDMJkEGUgJOZ9GdqUubJDx184N5v+znzsRMiipQzJur0xcEWgEwh6Yd/i6+TGL/9KK9HEtXDJiNcmk8GToeCiE4Xliw8jPqC8sJod35RGPo2Swr4iz+pZio3330k8WrC7GBXKDA=
Message-ID: <84144f020601050532l56c15be1i4938a84f6c212960@mail.gmail.com>
Date: Thu, 5 Jan 2006 15:32:28 +0200
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: 80 column line limit?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060105130249.GB29894@vrfy.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060105130249.GB29894@vrfy.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/5/06, Kay Sievers <kay.sievers@vrfy.org> wrote:
> Can't we relax the 80 column line rule to something more comfortable?
> These days descriptive variable/function names are much more valuable,
> I think.

I don't see the point, really. If your nesting is within reasonable
limits, long names are usually not a problem. And your nesting is too
deep, it should be fixed. Out of curiosity, what limit do you think
would work better to you?

                                        Pekka
