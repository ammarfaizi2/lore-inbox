Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751258AbWEPELX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751258AbWEPELX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 00:11:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751260AbWEPELX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 00:11:23 -0400
Received: from terminus.zytor.com ([192.83.249.54]:55487 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751258AbWEPELW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 00:11:22 -0400
Message-ID: <446950E3.4060601@zytor.com>
Date: Mon, 15 May 2006 21:11:15 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Jim Cromie <jim.cromie@gmail.com>
CC: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.17-rc4-mm1 nfsroot build err, looks related to klibc
References: <44692CA1.5000903@gmail.com>
In-Reply-To: <44692CA1.5000903@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jim Cromie wrote:
> 
> Im getting nfsroot build error on 2 configs, both carried forward
> from good rc4 and from rc3-mm1 builds.
> turning off nfsroot fixes the err.
> 

Could you throw me your configs, so I can try to reproduce it here?

	-hpa
