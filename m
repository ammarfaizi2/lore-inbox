Return-Path: <linux-kernel-owner+w=401wt.eu-S1751391AbXAULjg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751391AbXAULjg (ORCPT <rfc822;w@1wt.eu>);
	Sun, 21 Jan 2007 06:39:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751456AbXAULjg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Jan 2007 06:39:36 -0500
Received: from il.qumranet.com ([62.219.232.206]:41645 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751391AbXAULjf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Jan 2007 06:39:35 -0500
Message-ID: <45B350F2.5040102@argo.co.il>
Date: Sun, 21 Jan 2007 13:39:30 +0200
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Thomas Meyer <thomas@m3y3r.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: KVM: vmwrite error in
References: <45A9FC73.2000105@m3y3r.de>
In-Reply-To: <45A9FC73.2000105@m3y3r.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Meyer wrote:
> Hi.
>
> I have a few of these entries in my log buffer:
> vmwrite error: reg 6802 value d19e0464 (err 26626)
>
[...]

> Look's like a stack trace, but no oops. What does this mean? this 
> happens with kernel 2.6.20-rc4-gd39c9400 (two commits missing before 
> rc5, nothing kvm related, so...)
>

I've sent a patch for this some time ago, it's likely held back due to LCA.

-- 
error compiling committee.c: too many arguments to function

