Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932323AbVISGDe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932323AbVISGDe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 02:03:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932324AbVISGDe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 02:03:34 -0400
Received: from paleosilicon.orionmulti.com ([209.128.68.66]:37263 "EHLO
	paleosilicon.orionmulti.com") by vger.kernel.org with ESMTP
	id S932323AbVISGDe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 02:03:34 -0400
X-Envelope-From: hpa@zytor.com
Message-ID: <432E5498.9000805@zytor.com>
Date: Sun, 18 Sep 2005 23:03:04 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: 7eggert@gmx.de
CC: Bernd Petrovitsch <bernd@firmix.at>,
       =?ISO-8859-1?Q?=22Martin_v=2E_?= =?ISO-8859-1?Q?L=F6wis=22?= 
	<martin@v.loewis.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [Patch] Support UTF-8 scripts
References: <4Nvab-7o5-11@gated-at.bofh.it> <4Nvab-7o5-13@gated-at.bofh.it> <4Nvab-7o5-15@gated-at.bofh.it> <4Nvab-7o5-17@gated-at.bofh.it> <4Nvab-7o5-19@gated-at.bofh.it> <4Nvab-7o5-21@gated-at.bofh.it> <4Nvab-7o5-23@gated-at.bofh.it> <4Nvab-7o5-25@gated-at.bofh.it> <4Nvab-7o5-27@gated-at.bofh.it> <4NvjM-7CU-7@gated-at.bofh.it> <4NvjM-7CU-5@gated-at.bofh.it> <4NxbR-20S-1@gated-at.bofh.it> <4NEn7-3M5-7@gated-at.bofh.it> <4NTvO-yJ-13@gated-at.bofh.it> <4O1MJ-3Hf-5@gated-at.bofh.it> <4O8Oh-5jp-7@gated-at.bofh.it> <E1EH4lL-0001Iz-Lx@be1.lrz>
In-Reply-To: <E1EH4lL-0001Iz-Lx@be1.lrz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bodo Eggert wrote:
> 
> It will be the first POSIX kernel to correctly support utf-8 scripts.
> It's 2005, and according to other(?) posters, this should be standard.
> 

UTF-8, yes.  BOM bullshit, no.

	-hpa
