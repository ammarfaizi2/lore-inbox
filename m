Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030316AbVKPNE4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030316AbVKPNE4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 08:04:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030315AbVKPNE4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 08:04:56 -0500
Received: from zproxy.gmail.com ([64.233.162.207]:32371 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030314AbVKPNEz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 08:04:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hmc+MCW9ZoexSFVB5G53MstYLmzdi6ZWoWVJhL6F/uHtP7L64exLDPE7MzpYbla06ei1XTuTeA5kFXZp0Xj7WXOT8DDbbQ5hCCE6QV4QtAfFJaVyk41gHUj6BqwfagSrE461NNeJezNjwC68ezAXG6OebP8DiTWNxJlC6sUoGoo=
Message-ID: <6d6a94c50511160504j455e48ccn@mail.gmail.com>
Date: Wed, 16 Nov 2005 21:04:55 +0800
From: Aubrey <aubreylee@gmail.com>
To: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Alarm execl failed on 2.6.12
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <81b0412b0511160219s2eb020dfl93c6b5e23358f6bd@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <6d6a94c50511152348h1fab72fes@mail.gmail.com>
	 <81b0412b0511160219s2eb020dfl93c6b5e23358f6bd@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I know it got fixed.
I want to know how it is fixed. Is there a patch for it?
Thanks
-Aubrey

2005/11/16, Alex Riesen <raa.lkml@gmail.com>:
> On 11/16/05, Aubrey <aubreylee@gmail.com> wrote:
> > Running test can't stop in 3 seconds. But it should be.
> > Because the case can run properly on 2.6.11 and 2.6.13.
> > What difference about it?
>
> it was just broken and got fixed.
>
