Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030395AbVKPQQA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030395AbVKPQQA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 11:16:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030388AbVKPQQA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 11:16:00 -0500
Received: from nproxy.gmail.com ([64.233.182.204]:63089 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030395AbVKPQQA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 11:16:00 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JW8WQU/dKSKMUzLqrehZa8V+uB9GGIRYGKfTyteuBzWtttFtTr4HP6f2aB5ki6DHqPHLM64yW3rRWsrP2mY3xhPJmbMQrFp5kBzCiIYIarKcNANjixvKydiqGUGm3IkqqBQhD8o3c5Uh5PTpPrhLH3LffeH/BakjaE0YEMyRsJY=
Message-ID: <81b0412b0511160815y5baf10b7l6b1a00546a173f92@mail.gmail.com>
Date: Wed, 16 Nov 2005 17:15:58 +0100
From: Alex Riesen <raa.lkml@gmail.com>
To: Aubrey <aubreylee@gmail.com>
Subject: Re: Alarm execl failed on 2.6.12
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <6d6a94c50511160504j455e48ccn@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <6d6a94c50511152348h1fab72fes@mail.gmail.com>
	 <81b0412b0511160219s2eb020dfl93c6b5e23358f6bd@mail.gmail.com>
	 <6d6a94c50511160504j455e48ccn@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/16/05, Aubrey <aubreylee@gmail.com> wrote:
> I know it got fixed.
> I want to know how it is fixed. Is there a patch for it?

probably. You can try a binary search from 2.6.11 to 2.6.12. Really
simple using "git bisect".
