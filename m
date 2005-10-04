Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751188AbVJDJta@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188AbVJDJta (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 05:49:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751197AbVJDJta
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 05:49:30 -0400
Received: from zproxy.gmail.com ([64.233.162.193]:41041 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751188AbVJDJt3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 05:49:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lwTCERzqjGk4zlCvnBCCtYo5LrVSEbQWa8Gen5BMvP87opPwoS0/JeUkrvlG0T5LC5l7JaFtAV+KZSXZCdTcbcA8pkIpNJ3pXAR0OGbVpgMuWx5+d57F/CZ2prmUeS/5uugYASOjJEPiHJId9axFup7kQmesEbBhH5X5Nq+O/UA=
Message-ID: <aec7e5c30510040249x7246284fv26e1f281a690a087@mail.gmail.com>
Date: Tue, 4 Oct 2005 18:49:29 +0900
From: Magnus Damm <magnus.damm@gmail.com>
Reply-To: Magnus Damm <magnus.damm@gmail.com>
To: Hirokazu Takahashi <taka@valinux.co.jp>
Subject: Re: [PATCH 07/07] i386: numa emulation on pc
Cc: magnus@valinux.co.jp, linux-mm@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <20051004.165216.94769788.taka@valinux.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050930073232.10631.63786.sendpatchset@cherry.local>
	 <20050930073308.10631.24247.sendpatchset@cherry.local>
	 <20051004.165216.94769788.taka@valinux.co.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/4/05, Hirokazu Takahashi <taka@valinux.co.jp> wrote:
> It seems like you've forgot to bind cpus with emulated nodes as linux for
> x86_64 does. I don't think it's your intention.

True, not my intention. I will have a look at that. Thanks.

/ magnus
