Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751306AbWFUPSn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751306AbWFUPSn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 11:18:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751654AbWFUPSn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 11:18:43 -0400
Received: from tim.rpsys.net ([194.106.48.114]:9869 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S1751306AbWFUPSm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 11:18:42 -0400
Subject: Re: [PATCH] LED: add LED heartbeat trigger
From: Richard Purdie <rpurdie@rpsys.net>
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Cc: nish.aravamudan@gmail.com, 7eggert@gmx.de
In-Reply-To: <20060622.000138.130239297.anemo@mba.ocn.ne.jp>
References: <20060621.013603.132759710.anemo@mba.ocn.ne.jp>
	 <20060622.000138.130239297.anemo@mba.ocn.ne.jp>
Content-Type: text/plain
Date: Wed, 21 Jun 2006 16:17:39 +0100
Message-Id: <1150903059.5549.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-06-22 at 00:01 +0900, Atsushi Nemoto wrote:
> Add an LED trigger acts like a heart beat.  This can be used as a
> replacement of CONFIG_HEARTBEAT code exists in some arch's timer code.
> 
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Acked-by: Richard Purdie <rpurdie@rpsys.net>

