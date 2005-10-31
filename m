Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751381AbVJaF0S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751381AbVJaF0S (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 00:26:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751384AbVJaF0S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 00:26:18 -0500
Received: from zproxy.gmail.com ([64.233.162.198]:238 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751381AbVJaF0R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 00:26:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:organization:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=FLhNXKsRwhIZHrIKYIs0CNhkF0C2tagqcbvsx9uJMvPBM5mr+x8OFCBzizK8SEdJ8WgZtlWbja7AZ/DnID0KCDdxryNhqyjkVGQrlmKplcBxkzWFwI1B10IP3NdFgvmtX5aOYnRHsq2dZj0F4LFBqGGcTifmP4RSs3AXKgGmo9E=
Message-ID: <4365AAEE.9000409@gmail.com>
Date: Mon, 31 Oct 2005 16:26:06 +1100
From: Grant Coady <gcoady@gmail.com>
Organization: http://bugsplatter.mine.nu/
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pci_ids: remove non-referenced symbols from pci_ids.h
References: <200510290000.j9T00Bqd001135@hera.kernel.org> <20051031024217.GA25709@redhat.com> <436591A5.20609@gmail.com> <20051031041313.GA1939@redhat.com>
In-Reply-To: <20051031041313.GA1939@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> At least 2 distros are carrying patches removing the BROKEN attribute
> on the advansys Kconfig for some architectures. The users of those kernels
> using their advansys controllers without any issue at all.

So why are your driver patches not in mainline then?

Grant.
