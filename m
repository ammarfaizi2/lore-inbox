Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266203AbSKFWwM>; Wed, 6 Nov 2002 17:52:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266204AbSKFWwM>; Wed, 6 Nov 2002 17:52:12 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:64261
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S266203AbSKFWwM>; Wed, 6 Nov 2002 17:52:12 -0500
Subject: RE: Regarding zerocopy implementation ...
From: Robert Love <rml@tech9.net>
To: Manish Lachwani <manish@Zambeel.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
In-Reply-To: <233C89823A37714D95B1A891DE3BCE5202AB184B@xch-a.win.zambeel.com>
References: <233C89823A37714D95B1A891DE3BCE5202AB184B@xch-a.win.zambeel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 06 Nov 2002 17:45:46 -0500
Message-Id: <1036622746.781.1421.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-11-06 at 17:01, Manish Lachwani wrote:

> Thanks for the response. When you say zerocopy networking, do you refer to
> zerocopy receives too? What linux kernel version offers this support? I am
> making use of 2.4.17 ...

No, only sending is supported.  See sendfile().

Yes, zero copy is in 2.4.17.

	Robert Love

