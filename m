Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264859AbSKTKN5>; Wed, 20 Nov 2002 05:13:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264983AbSKTKN5>; Wed, 20 Nov 2002 05:13:57 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:33038
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S264859AbSKTKN5>; Wed, 20 Nov 2002 05:13:57 -0500
Subject: Re: [patch] remove magic numbers in block queue initialization
From: Robert Love <rml@tech9.net>
To: Jens Axboe <axboe@suse.de>
Cc: akpm@digeo.com, linux-kernel@vger.kernel.org
In-Reply-To: <20021120084401.GH11884@suse.de>
References: <1037747198.1252.2259.camel@phantasy>
	 <20021120084401.GH11884@suse.de>
Content-Type: text/plain
Organization: 
Message-Id: <1037787670.1254.3140.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 20 Nov 2002 05:21:10 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-11-20 at 03:44, Jens Axboe wrote:

> No, please leave these alone, testing is on-going in these parts right
> now.

Did you look at the patch?  It just pulls the magic numbers out and uses
defines.  Should make testing easier.

	Robert Love

