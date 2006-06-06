Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932084AbWFFFE2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932084AbWFFFE2 (ORCPT <rfc822;akpm@zip.com.au>);
	Tue, 6 Jun 2006 01:04:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932102AbWFFFE2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 01:04:28 -0400
Received: from terminus.zytor.com ([192.83.249.54]:60067 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932084AbWFFFE2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 01:04:28 -0400
Message-ID: <44850CC6.6040002@zytor.com>
Date: Mon, 05 Jun 2006 22:04:06 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Felix Oxley <lkml@oxley.org>
CC: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [2.6.17-rc5-mm3] Fails to compile on PowerBook
References: <2FFC6FA0-510F-421F-8D66-AD93EFED10C2@oxley.org>
In-Reply-To: <2FFC6FA0-510F-421F-8D66-AD93EFED10C2@oxley.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Felix Oxley wrote:
> 2.6.17-rc5 is ok, but mm3 gives the following error:

Which distro?

What does "ld -v" output?

I have already received one bug report which seems to indicate that
"ld -R" is broken on the version of binutils which is in the current 
gentoo ppc.

	-hpa

