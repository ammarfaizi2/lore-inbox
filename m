Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264989AbTFCMsY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 08:48:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264990AbTFCMsX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 08:48:23 -0400
Received: from imsantv20.netvigator.com ([210.87.250.76]:32231 "EHLO
	imsantv20.netvigator.com") by vger.kernel.org with ESMTP
	id S264989AbTFCMsW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 08:48:22 -0400
From: Michael Frank <mflt1@micrologica.com.hk>
To: Jakob Oestergaard <jakob@unthought.net>
Subject: Re: NFS io errors on transfer from system running 2.4 to system running 2.5
Date: Tue, 3 Jun 2003 21:01:27 +0800
User-Agent: KMail/1.5.2
Cc: linux-kernel@vger.kernel.org
References: <200306031912.53569.mflt1@micrologica.com.hk> <200306032043.28141.mflt1@micrologica.com.hk> <20030603125247.GD14947@unthought.net>
In-Reply-To: <20030603125247.GD14947@unthought.net>
X-OS: GNU/Linux 2.5.70
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306032101.27215.mflt1@micrologica.com.hk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 03 June 2003 20:52, Jakob Oestergaard wrote:
>
> I always use hard,intr so that I can manually interrupt hanging jobs,
> but also know that they do not randomly fail just because a few packets
> get dropped on my network.  This seems to be the common setup, as far as
> I know.
>

Thank you,

I will try hard, intr

Regards
Michael

