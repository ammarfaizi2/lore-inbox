Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932397AbVLENsr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932397AbVLENsr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 08:48:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932418AbVLENsr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 08:48:47 -0500
Received: from yzordderrex.netnoteinc.com ([212.17.35.167]:41642 "EHLO
	yzordderrex.lincor.com") by vger.kernel.org with ESMTP
	id S932397AbVLENsr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 08:48:47 -0500
Message-ID: <439444CD.3000205@draigBrady.com>
Date: Mon, 05 Dec 2005 13:46:53 +0000
From: =?ISO-8859-1?Q?P=E1draig_Brady?= <P@draigBrady.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stephen Hemminger <shemminger@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fls in asm for i386
References: <20051202162240.746c436e@localhost.localdomain>
In-Reply-To: <20051202162240.746c436e@localhost.localdomain>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Hemminger wrote:

>There is a single instruction on i386 to find largest set bit;
>so it makes sense to use it (like we use bfs for ffs()).
>  
>
Interesting, I thought this had already been done:
http://lkml.org/lkml/2003/1/28/296
http://lkml.org/lkml/2003/4/29/173

Pádraig.
