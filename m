Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267828AbUBRSvd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 13:51:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267829AbUBRSvd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 13:51:33 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:36584 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S267828AbUBRStx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 13:49:53 -0500
Message-ID: <4033B3CC.2030609@namesys.com>
Date: Wed, 18 Feb 2004 10:49:48 -0800
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: martin f krafft <madduck@madduck.net>
CC: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: the crux with DMA
References: <20040218112052.GA8001@diamond.madduck.net>
In-Reply-To: <20040218112052.GA8001@diamond.madduck.net>
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

martin f krafft wrote:

>.
>
>I know that neither, reiserfs nor ext3, are high-performance, 
>
both ext3 and reiserfs are higher performance than XFS for typical file 
sizes.  XFS does very well for streaming video though (as does reiser4).
