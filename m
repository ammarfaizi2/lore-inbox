Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271412AbTHRMgi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 08:36:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271685AbTHRMgi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 08:36:38 -0400
Received: from hera.cwi.nl ([192.16.191.8]:12775 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S271412AbTHRMgh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 08:36:37 -0400
From: Andries.Brouwer@cwi.nl
Date: Mon, 18 Aug 2003 14:36:34 +0200 (MEST)
Message-Id: <UTC200308181236.h7ICaYK23348.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, hch@infradead.org
Subject: Re: [PATCH] Re: [PATCH] scsi.h uses "u8" which isn't defined.
Cc: Dominik.Strasser@t-online.de, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From hch@infradead.org  Mon Aug 18 14:24:53 2003

    On Mon, Aug 18, 2003 at 02:19:41PM +0200, Andries.Brouwer@cwi.nl wrote:
    > The right approach is not to break userspace without any kernel
    > benefit whatsoever, but to eliminate the accumulated cruft from
    > scsi.h.

    Userspace is supposed to use the glibc <scsi/scsi.h> which is there
    for exactly that reason.

Yes, I already know that you know the mantra.

But you make it sound as if this sad situation is optimal
and never to be changed.

