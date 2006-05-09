Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751384AbWEIOuU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751384AbWEIOuU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 10:50:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751778AbWEIOuL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 10:50:11 -0400
Received: from dvhart.com ([64.146.134.43]:1763 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S1751776AbWEIOt4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 10:49:56 -0400
Message-ID: <4460AC0D.1060900@mbligh.org>
Date: Tue, 09 May 2006 07:49:49 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wright <chrisw@sous-sol.org>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org,
       xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>
Subject: Re: [RFC PATCH 03/35] Add Xen interface header files
References: <20060509084945.373541000@sous-sol.org> <20060509085147.903310000@sous-sol.org>
In-Reply-To: <20060509085147.903310000@sous-sol.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This clearly doesn't belong:

> +/*
> + * Local variables:
> + * mode: C
> + * c-set-style: "BSD"
> + * c-basic-offset: 4
> + * tab-width: 4
> + * indent-tabs-mode: nil
> + * End:
> + */

????


> +/*
> + * Local variables:
> + * mode: C
> + * c-set-style: "BSD"
> + * c-basic-offset: 4
> + * tab-width: 4
> + * indent-tabs-mode: nil
> + * End:
> + */

???

And the rest of them.
