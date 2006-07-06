Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965068AbWGFIff@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965068AbWGFIff (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 04:35:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965107AbWGFIff
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 04:35:35 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:20641 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S965068AbWGFIfe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 04:35:34 -0400
Subject: Re: [PATCH-2.4] Typo in cdrom.c also in linux-2.4
From: Marcel Holtmann <marcel@holtmann.org>
To: Andreas Haumer <andreas@xss.co.at>
Cc: linux-kernel@vger.kernel.org, marcelo@kvack.org, w@1wt.eu
In-Reply-To: <44ACC870.2000609@xss.co.at>
References: <44ACC870.2000609@xss.co.at>
Content-Type: text/plain
Date: Thu, 06 Jul 2006 10:35:32 +0200
Message-Id: <1152174932.20938.2.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

> are you aware of the discussion at
> <http://bugzilla.kernel.org/show_bug.cgi?id=2966> ?
> 
> The typo seems to exist in linux-2.4 too, at least in
> 2.4.32, 2.4.32-hf32.6 and 2.4.33pre3 (which is what
> I checked today)

I tracked this issue down and it exists since 2.2.16 when the DVD
support was introduced.

Regards

Marcel


