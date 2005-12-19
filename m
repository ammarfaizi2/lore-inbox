Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932530AbVLSIuf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932530AbVLSIuf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 03:50:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932584AbVLSIue
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 03:50:34 -0500
Received: from pne-smtpout2-sn2.hy.skanova.net ([81.228.8.164]:57803 "EHLO
	pne-smtpout2-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S932530AbVLSIue (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 03:50:34 -0500
Date: Mon, 19 Dec 2005 09:50:31 +0100
From: Voluspa <lista1@telia.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.15-rc6
Message-Id: <20051219095031.28d70b19.lista1@telia.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Total loss of ACPI C-states (even C1 is unused) has survived from -rc5
to -rc6. See short thread:

[ACPI] Fw: Re: 2.6.15-rc5-mm1
http://marc.theaimsgroup.com/?t=113383872000001&r=1&w=2

The issue seems to be fixed in 2.6.15-rc5-mm3, but no public figure has
explained how or sent any specific patch for it:

[ACPI] Re: 2.6.15-rc5-mm3
http://marc.theaimsgroup.com/?l=acpi4linux&m=113464591421744&w=2

Mvh
Mats Johannesson
--
