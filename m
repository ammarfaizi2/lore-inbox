Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264304AbTEOXAR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 19:00:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264302AbTEOXAR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 19:00:17 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:42245 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S264300AbTEOXAQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 19:00:16 -0400
Subject: Re: [patch] NCR5380.c fix
From: James Bottomley <James.Bottomley@steeleye.com>
To: Andries.Brouwer@cwi.nl
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>, torvalds@transmeta.com
In-Reply-To: <UTC200305152310.h4FNA1X19100.aeb@smtp.cwi.nl>
References: <UTC200305152310.h4FNA1X19100.aeb@smtp.cwi.nl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 15 May 2003 18:12:53 -0500
Message-Id: <1053040375.4021.32.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-05-15 at 18:10, Andries.Brouwer@cwi.nl wrote:
> I wouldn't mind merging these three and choosing the SCSI_STATUS_ prefix.

I'll go for that if you want to do the honours.

James


