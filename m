Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262811AbTE2UwA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 16:52:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262805AbTE2Uv7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 16:51:59 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:31495 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262776AbTE2Uv5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 16:51:57 -0400
Subject: Re: 2.5.70-mm2: NCR_D700.c doesn't compile
From: James Bottomley <James.Bottomley@steeleye.com>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Andrew Morton <akpm@digeo.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <20030529205742.GI5643@fs.tum.de>
References: <20030529012914.2c315dad.akpm@digeo.com> 
	<20030529205742.GI5643@fs.tum.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 29 May 2003 17:01:56 -0400
Message-Id: <1054242118.1819.465.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-05-29 at 16:57, Adrian Bunk wrote:
> It seems the following compile error comes from Linus' tree:

Yes, I already have the fix (which is to add the correct argument to the
function).

James


