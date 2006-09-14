Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751267AbWINLzg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751267AbWINLzg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 07:55:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751268AbWINLzg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 07:55:36 -0400
Received: from mail.suse.de ([195.135.220.2]:2997 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751267AbWINLzf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 07:55:35 -0400
From: Andi Kleen <ak@suse.de>
To: Dave Jones <davej@redhat.com>
Subject: Re: [PATCH] mpparse.c:231: warning: comparison is always false
Date: Thu, 14 Sep 2006 12:12:50 +0200
User-Agent: KMail/1.9.1
Cc: Jarek Poplawski <jarkao2@o2.pl>, linux-kernel@vger.kernel.org
References: <20060913065010.GA2110@ff.dom.local> <20060913164251.GD13956@redhat.com>
In-Reply-To: <20060913164251.GD13956@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609141212.50636.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 13 September 2006 18:42, Dave Jones wrote:
> On Wed, Sep 13, 2006 at 08:50:10AM +0200, Jarek Poplawski wrote:
>  > Probably after 2.6.18-rc6-git1 there is this cc warning:
>  > "arch/i386/kernel/mpparse.c:231: warning: comparison is
>  > always false due to limited range of data type".
>  > Maybe this patch will be helpful.
>  >

It's already fixed.

-Andi

