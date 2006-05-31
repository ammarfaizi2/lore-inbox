Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751305AbWEaCpS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751305AbWEaCpS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 22:45:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751414AbWEaCpS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 22:45:18 -0400
Received: from rune.pobox.com ([208.210.124.79]:16546 "EHLO rune.pobox.com")
	by vger.kernel.org with ESMTP id S1751305AbWEaCpQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 22:45:16 -0400
Date: Tue, 30 May 2006 19:45:09 -0700
From: Paul Dickson <paul@permanentmail.com>
To: Dave Jones <davej@redhat.com>
Cc: sanjoy@mrao.cam.ac.uk, rjw@sisk.pl, linux-kernel@vger.kernel.org
Subject: Re: Bisects that are neither good nor bad
Message-Id: <20060530194509.80a7891b.paul@permanentmail.com>
In-Reply-To: <20060529145255.GB32274@redhat.com>
References: <20060528140238.2c25a805.dickson@permanentmail.com>
	<20060528140854.34ddec2a.paul@permanentmail.com>
	<200605282324.13431.rjw@sisk.pl>
	<200605282324.13431.rjw@sisk.pl>
	<20060528213414.GC5741@redhat.com>
	<r6u079rrik.fsf@skye.ra.phy.cam.ac.uk>
	<20060529145255.GB32274@redhat.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.9.1; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 May 2006 10:52:55 -0400, Dave Jones wrote:

> The SATA fix Mark proposed also didn't improve the situation for me :-/

Fedora kernel 2230 is supposed to include the patch, yet resuming doesn't
work with that kernel.

	-Paul

