Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267863AbUHPTGn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267863AbUHPTGn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 15:06:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267889AbUHPTGn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 15:06:43 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:27267 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S267863AbUHPTGl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 15:06:41 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Alan Cox <alan@redhat.com>
Subject: Re: PATCH: IDE - fix various comments remove never changing ifdef
Date: Mon, 16 Aug 2004 20:29:43 +0200
User-Agent: KMail/1.6.2
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, torvalds@osdl.org
References: <20040815143546.GA6284@devserv.devel.redhat.com>
In-Reply-To: <20040815143546.GA6284@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408162029.43797.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 15 August 2004 16:35, Alan Cox wrote:
> No code changes in this patch just documenting

If you want to remove FANCY_STATUS_DUMPS define please make
a separate patch and remove it globally.
