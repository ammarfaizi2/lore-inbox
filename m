Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964783AbVHOORa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964783AbVHOORa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 10:17:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964787AbVHOORa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 10:17:30 -0400
Received: from amdext4.amd.com ([163.181.251.6]:36748 "EHLO amdext4.amd.com")
	by vger.kernel.org with ESMTP id S964783AbVHOORa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 10:17:30 -0400
X-Server-Uuid: 5FC0E2DF-CD44-48CD-883A-0ED95B391E89
From: "Ray Bryant" <raybry@mpdtxmail.amd.com>
To: "Xuekun Hu" <xuekun.hu@gmail.com>
Subject: Re: lockmeter: fix lock counter roll over issue
Date: Mon, 15 Aug 2005 09:16:53 -0500
User-Agent: KMail/1.8
cc: linux-kernel@vger.kernel.org, raybry@mpdtxmail.amd.com, akpm@osdl.org,
       hawkes@sgi.com
References: <398d69300508132100327e3712@mail.gmail.com>
 <398d69300508150035246230af@mail.gmail.com>
In-Reply-To: <398d69300508150035246230af@mail.gmail.com>
MIME-Version: 1.0
Message-ID: <200508150916.54276.raybry@mpdtxmail.amd.com>
X-WSS-ID: 6F1E7C632CC9889162-01-01
Content-Type: text/plain;
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 15 August 2005 02:35, Xuekun Hu wrote:
> Does anyone have inputs?
>

Xuekun ,

I was on vacation last week.   I just saw your patch yesterday.  It looks 
reasonable, but I will test it later today.

You should also cc John Hawkes (hawkes@sgi.com).

Also, please note my email address change:  my current email address is
raybry@mpdtxmail.amd.com.

Andrew is not so much interested in these changes as the lockmeter patch is 
not in -mm.
-- 
Ray Bryant
AMD Performance Labs                   Austin, Tx
512-602-0038 (o)                 512-507-7807 (c)

