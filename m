Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261319AbVGLNVf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261319AbVGLNVf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 09:21:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261313AbVGLNVf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 09:21:35 -0400
Received: from mta07-winn.ispmail.ntl.com ([81.103.221.47]:662 "EHLO
	mta07-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S261319AbVGLNVe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 09:21:34 -0400
Message-ID: <42D3C3E0.6030103@gentoo.org>
Date: Tue, 12 Jul 2005 14:21:36 +0100
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050710)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Patrick McHardy <kaber@trash.net>
Cc: linux-kernel@vger.kernel.org, netfilter-devel@lists.netfilter.org
Subject: Re: 2.6.12 netfilter: local packets marked as invalid
References: <42CE86B5.2080705@gentoo.org> <42CE8E96.1040905@trash.net> <42CEA5E4.40009@gentoo.org> <42D3B063.3000207@trash.net>
In-Reply-To: <42D3B063.3000207@trash.net>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick McHardy wrote:
> We decided to revert the responsible change because it caused problems
> in other areas as well. This patch should fix your problem.

Thanks, it works. If you decide to revisit this in the future, feel free to
send me a patch and I will help test it.

Daniel
