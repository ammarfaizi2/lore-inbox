Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261849AbSJQHeu>; Thu, 17 Oct 2002 03:34:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261852AbSJQHeu>; Thu, 17 Oct 2002 03:34:50 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:56324
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S261849AbSJQHet>; Thu, 17 Oct 2002 03:34:49 -0400
Subject: RE: benchmarks of O_STREAMING in 2.5
From: Robert Love <rml@tech9.net>
To: Giuliano Pochini <pochini@shiny.it>
Cc: linux-kernel@vger.kernel.org, akpm@digeo.com
In-Reply-To: <XFMail.20021017093356.pochini@shiny.it>
References: <XFMail.20021017093356.pochini@shiny.it>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 17 Oct 2002 03:40:58 -0400
Message-Id: <1034840459.718.431.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-10-17 at 03:33, Giuliano Pochini wrote:
> 
> > I gave the O_STREAMING in Andrew's 2.5-mm tree the treatment..
> >       O_STREAMING     Wall time to complete Kernel compile
> >       Yes             5m30.494s
> >       No              4m59.661s
> >
> > So, uh, Andrew's 2.5 code works ;-)
> 
> ?? O_STREAMING makes it slower or is it a typo ?

Yes, typo, those should be switched.

	Robert Love

