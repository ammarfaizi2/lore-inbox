Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030331AbWGaTHY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030331AbWGaTHY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 15:07:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030332AbWGaTHY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 15:07:24 -0400
Received: from terminus.zytor.com ([192.83.249.54]:62372 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1030331AbWGaTHY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 15:07:24 -0400
Message-ID: <44CE54D6.4040309@zytor.com>
Date: Mon, 31 Jul 2006 12:07:02 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Matt Mackall <mpm@selenic.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] x86 built-in command line (resend)
References: <20060731171259.GH6908@waste.org>
In-Reply-To: <20060731171259.GH6908@waste.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall wrote:
> I'm resending this as-is because the earlier thread petered out
> without any strong arguments against this approach. x86_64 patch to
> follow.

"No strong arguments?"

I still maintain that this patch has the wrong priority in case more 
than one set of arguments are provided.

	-hpa
