Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269332AbUINOeA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269332AbUINOeA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 10:34:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269330AbUINOd7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 10:33:59 -0400
Received: from [213.146.154.40] ([213.146.154.40]:22454 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S269332AbUINOdr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 10:33:47 -0400
Subject: Re: Add skeleton "generic IO mapping" infrastructure.
From: David Woodhouse <dwmw2@infradead.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <41470074.9010900@pobox.com>
References: <200409132206.i8DM6dSC030620@hera.kernel.org>
	 <1095152147.9144.254.camel@imladris.demon.co.uk>
	 <41470074.9010900@pobox.com>
Content-Type: text/plain
Message-Id: <1095172422.24547.185.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Tue, 14 Sep 2004 15:33:42 +0100
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-09-14 at 10:30 -0400, Jeff Garzik wrote:
> Override it in your arch if you don't like the generic version ;-)

If you must... but make it take a cookie with enough space to give the
required information -- not just an unsigned long.

-- 
dwmw2

