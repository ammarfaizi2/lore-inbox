Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267525AbSLEWNd>; Thu, 5 Dec 2002 17:13:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267526AbSLEWNd>; Thu, 5 Dec 2002 17:13:33 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:15626
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S267525AbSLEWNc>; Thu, 5 Dec 2002 17:13:32 -0500
Subject: Re: 2.5: ext3 bug or dying drive?
From: Robert Love <rml@tech9.net>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1039126335.1942.32.camel@phantasy>
References: <1039123660.1433.12.camel@phantasy>
	 <3DEFCD3A.29C98E8D@digeo.com>  <1039126335.1942.32.camel@phantasy>
Content-Type: text/plain
Organization: 
Message-Id: <1039126875.2065.58.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 05 Dec 2002 17:21:15 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-12-05 at 17:12, Robert Love wrote:

> > Bottom line: dunno.
> 
> Me neither.  Quite an anomaly.

I should add I have some file corruption.

It is probably related to fsck cleaning house - it seems some of the
executables I had open during the nose dive are bad.  Reinstalling the
RPM packages fixed that.

Poop.

	Robert Love

