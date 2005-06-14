Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261223AbVFNQOI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261223AbVFNQOI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 12:14:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261229AbVFNQMb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 12:12:31 -0400
Received: from mail.dvmed.net ([216.237.124.58]:39401 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261223AbVFNQLA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 12:11:00 -0400
Message-ID: <42AF018A.3030705@pobox.com>
Date: Tue, 14 Jun 2005 12:10:50 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Luca Falavigna <dktrkranz@gmail.com>
CC: akpm@osdl.org, mingo@elte.hu,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Using msleep() instead of HZ
References: <42AEC01A.3060403@gmail.com>
In-Reply-To: <42AEC01A.3060403@gmail.com>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luca Falavigna wrote:
> Hi Andrew,
> Ingo suggested me to forward you my patches which do use of msleep in order to
> perform short delays instead of using HZ directly.
> I already sent him some, but they are against his -RT tree.
> This is a modified patch, built against 2.6.12-rc6.
> 
> Signed-off by: Luca Falavigna <dktrkranz@gmail.com>

ACK


