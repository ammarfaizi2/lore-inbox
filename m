Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266473AbUIILzk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266473AbUIILzk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 07:55:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263001AbUIILzi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 07:55:38 -0400
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:22219 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S266479AbUIILzb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 07:55:31 -0400
From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
To: Erik Jacobson <erikj@subway.americas.sgi.com>
Subject: Re: [PATCH] sgiioc4 driver needs /proc/ide entries
Date: Thu, 9 Sep 2004 13:54:38 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
References: <Pine.SGI.4.53.0409081059500.77854@subway.americas.sgi.com> <Pine.SGI.4.53.0409081323210.87183@subway.americas.sgi.com> <Pine.SGI.4.53.0409081533420.98673@subway.americas.sgi.com>
In-Reply-To: <Pine.SGI.4.53.0409081533420.98673@subway.americas.sgi.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409091354.38297.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 08 September 2004 22:50, Erik Jacobson wrote:
> Now that I understand we don't need to create /proc/ide/sgiioc4, the patch
> is very simple.
> 
> Below you will find the new patch.  I just tested it now and it works
> properly - /proc/ide is properly populated with this patch (and not
> populated on altix without it).

merged by Linus
