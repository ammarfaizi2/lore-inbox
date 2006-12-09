Return-Path: <linux-kernel-owner+w=401wt.eu-S1761360AbWLINyc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761360AbWLINyc (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 08:54:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761333AbWLINyc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 08:54:32 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:61166 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761360AbWLINyb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 08:54:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=SZsRk8l5XtM998fnL8uYlLRD7MPFL2lt9vt541aDrRySgtsVcN0u2/q8Ev6OHAZWGrbmfIBHEnH9D9ODuqyRAmDQFRyr3GLo2ZVPUU/AskdpwByoLjACBZqmWiUT4kynAOYICgXtgzeSSbRxYVUdPfQJb7WGx5zI1JfJ0CR7bAo=
Message-ID: <84144f020612090554o571f142bt7f59db2c0dfa782f@mail.gmail.com>
Date: Sat, 9 Dec 2006 15:54:30 +0200
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Subject: Re: Re: [PATCH] kcalloc: Re-order the first two out-of-order args to kcalloc().
Cc: "Linux kernel mailing list" <linux-kernel@vger.kernel.org>
In-Reply-To: <84144f020612090553n7fe309b7u54dd7f58424c4008@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.64.0612081837020.6610@localhost.localdomain>
	 <84144f020612090553n7fe309b7u54dd7f58424c4008@mail.gmail.com>
X-Google-Sender-Auth: fe667b5b46756315
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/9/06, Pekka Enberg <penberg@cs.helsinki.fi> wrote:
> You really ought to send these cleanups to akpm@osdl.org with LKML
> cc'd to get them merged.

...or even better, the relevant maintainer.
