Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754150AbWKGJhP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754150AbWKGJhP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 04:37:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754154AbWKGJhP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 04:37:15 -0500
Received: from smtp.osdl.org ([65.172.181.4]:23968 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1754150AbWKGJhN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 04:37:13 -0500
Date: Tue, 7 Nov 2006 01:37:02 -0800
From: Andrew Morton <akpm@osdl.org>
To: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [PATCH 2.6.19-rc4] usb urb unlink/free clenup
Message-Id: <20061107013702.46b5710f.akpm@osdl.org>
In-Reply-To: <200611071030.57152.m.kozlowski@tuxland.pl>
References: <200611062228.38937.m.kozlowski@tuxland.pl>
	<20061106184949.87b2f23a.akpm@osdl.org>
	<200611071030.57152.m.kozlowski@tuxland.pl>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Nov 2006 10:30:56 +0100
Mariusz Kozlowski <m.kozlowski@tuxland.pl> wrote:

> Do I send the next diff against the work I already did?

Yes please.
