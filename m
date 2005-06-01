Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261428AbVFAP0Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261428AbVFAP0Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 11:26:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261424AbVFAPYc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 11:24:32 -0400
Received: from rproxy.gmail.com ([64.233.170.198]:11904 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261431AbVFAPXm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 11:23:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=oPuX6Gz7XmJE4II235vzmH42bhgcWtiZDOZZeX4PkpC6rNdeDzMPlPNT1uC35GDBAQ/DNCJdpPc3RJT5boiOwviJydgeo/rTXyMo+yN5KPO6Z0l+edluP6n9WLlGFqCDLtukVWaQw7wS4S6ZVvcgufFHv+b26Zstk6n77SlN/wk=
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Hirokazu Takata <takata@linux-m32r.org>
Subject: Re: [PATCH 2.6.12-rc5-mm1] m32r: Remove include/asm-m32r/m32102peri.h
Date: Wed, 1 Jun 2005 19:28:25 +0400
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org, fujiwara@linux-m32r.org
References: <20050601.222742.782288423.takata.hirokazu@renesas.com>
In-Reply-To: <20050601.222742.782288423.takata.hirokazu@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506011928.26035.adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 01 June 2005 17:27, Hirokazu Takata wrote:
> -typedef	void	V;
> -typedef	char	B;
> -typedef	short	S;
> -typedef	int		W;
> -typedef	long	L;
> -typedef	float	F;
> -typedef	double	D;
> -typedef	unsigned char	UB;
> -typedef	unsigned short	US;
> -typedef	unsigned int	UW;
> -typedef	unsigned long	UL;
> -typedef	const unsigned int	CUW;

Thanks!
