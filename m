Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965275AbVKBVpD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965275AbVKBVpD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 16:45:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965277AbVKBVpD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 16:45:03 -0500
Received: from zproxy.gmail.com ([64.233.162.196]:43799 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965275AbVKBVpA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 16:45:00 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tZoo/xnv8DePjkFvBIug4bjWIwsmYqEJItoYmPmvPvD4PVQ7eS+My4QO2/K81XmsMbc8P5ydDxJt+bxRFpkwkYkjRonVpotNV7l1nypZr9/EBq3bd5z5Mjv3KTYkL4fICZWmF6SncbTYRRvyGnqzY7fr/zNI316xhWUiWpesJbA=
Message-ID: <39e6f6c70511021345w5e163239w8a5f2f6450860acb@mail.gmail.com>
Date: Wed, 2 Nov 2005 19:45:00 -0200
From: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
To: David Stevens <dlstevens@us.ibm.com>
Subject: Re: [PATCH][MCAST]IPv6: small fix for ip6_mc_msfilter(...)
Cc: Yan Zheng <yanzheng@21cn.com>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
In-Reply-To: <OF19AE07D9.BF2B28D4-ON882570AC.0083498D-882570AC.00835D3A@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4367FF22.3030601@21cn.com>
	 <OF19AE07D9.BF2B28D4-ON882570AC.0083498D-882570AC.00835D3A@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/1/05, David Stevens <dlstevens@us.ibm.com> wrote:
> Looks good. Thanks, Yan.
>
>                         +-DLS

Thanks everybody, Applied.

- Arnaldo
