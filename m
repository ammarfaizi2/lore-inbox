Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263386AbTDCNIr>; Thu, 3 Apr 2003 08:08:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263388AbTDCNIr>; Thu, 3 Apr 2003 08:08:47 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:3332 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S263386AbTDCNIq>; Thu, 3 Apr 2003 08:08:46 -0500
Date: Thu, 3 Apr 2003 17:20:02 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Tomoya TAKA <tomoya@olive.plala.or.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.4.21-pre6] small fix of arch/alpha/kernel/entry.S
Message-ID: <20030403172002.A768@jurassic.park.msu.ru>
References: <20030403221603.620cd096.tomoya@olive.plala.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030403221603.620cd096.tomoya@olive.plala.or.jp>; from tomoya@olive.plala.or.jp on Thu, Apr 03, 2003 at 10:16:03PM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 03, 2003 at 10:16:03PM +0900, Tomoya TAKA wrote:
> Build of 2.4.21-pre6 kernel for Alpha results in linkage errors
> because of a name change of kernel_thread in arch/alpha/kernel/entry.S.

Fixed in -pre7.

Ivan.
