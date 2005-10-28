Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030578AbVJ1STt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030578AbVJ1STt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 14:19:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030607AbVJ1STt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 14:19:49 -0400
Received: from xproxy.gmail.com ([66.249.82.196]:36840 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030513AbVJ1STs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 14:19:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=M3QDrO3lCk/M0FiZ2DUueP8ZaWs200Y4x+ihvtCDBX3cw0qyWCGHwxfXpumOg2BXHL/uvr36W0ZtgFzdTVNzFQ72zOmsthUQC9ilGW8LVuy3nmZsiUyjsenLOOyeujlc7UJojb3bat8s35nKHVHURpgEqKl3/5Xht63TvEz2jJo=
Message-ID: <39e6f6c70510281119v1b43678eq50da211ef1ca26b5@mail.gmail.com>
Date: Fri, 28 Oct 2005 16:19:47 -0200
From: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
To: David Stevens <dlstevens@us.ibm.com>
Subject: Re: [PATH] [MCAST] IPv6: Fix algorithm to compute Querier's Query Interval and Maximum Response Delay
Cc: Yan Zheng <yanzheng@21cn.com>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, netdev-owner@vger.kernel.org
In-Reply-To: <OF7FABC1EE.FDB8A0D4-ON882570A8.005EDBB4-882570A8.005F14D9@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43624B98.6010405@21cn.com>
	 <OF7FABC1EE.FDB8A0D4-ON882570A8.005EDBB4-882570A8.005F14D9@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/28/05, David Stevens <dlstevens@us.ibm.com> wrote:
> Yes, I think you're correct.
>
> Acked-by: David L Stevens <dlstevens@us.ibm.com>

Thanks, applying to my tree.

- Arnaldo
