Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751250AbWEOUaL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751250AbWEOUaL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 16:30:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751341AbWEOUaL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 16:30:11 -0400
Received: from terminus.zytor.com ([192.83.249.54]:7400 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751250AbWEOUaK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 16:30:10 -0400
Message-ID: <4468E4C7.9040701@zytor.com>
Date: Mon, 15 May 2006 13:29:59 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org,
       Sam Ravnborg <sam@ravnborg.org>
Subject: Re: 2.6.17-rc4-mm1 klibc build misbehavior
References: <200605151907.k4FJ7Olk006598@turing-police.cc.vt.edu> <20060515121630.2a91235b.akpm@osdl.org>
In-Reply-To: <20060515121630.2a91235b.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Valdis.Kletnieks@vt.edu wrote:
>> Why does touching scripts/mod/modpost.c end up rebuilding all of klibc?
>>
>> Oddly enough, it *didn't* force a rebuild of all the *.ko files.
>>
> cc added.

Added Sam as well.

	-hpa
