Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267615AbSKSXQm>; Tue, 19 Nov 2002 18:16:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267612AbSKSXPe>; Tue, 19 Nov 2002 18:15:34 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:25102
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S267600AbSKSXOi>; Tue, 19 Nov 2002 18:14:38 -0500
Subject: Re: [patch] remove magic numbers in block queue initialization
From: Robert Love <rml@tech9.net>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3DDAC6D4.F0F78941@digeo.com>
References: <1037747198.1252.2259.camel@phantasy>
	 <3DDAC6D4.F0F78941@digeo.com>
Content-Type: text/plain
Organization: 
Message-Id: <1037748107.1254.2286.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 19 Nov 2002 18:21:47 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-11-19 at 18:18, Andrew Morton wrote:

> Spose so.  Sometime soon these need to be per-queue rather than global,
> and set to intelligent defaults by the driver and runtime tunable
> via files in /whereveritsmounted.

Yah I was thinking of making them sysctl^Wsysfs files.

That can be done in the future, I guess.

Thanks,

	Robert Love

