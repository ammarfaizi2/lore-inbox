Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262349AbVAQR0k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262349AbVAQR0k (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 12:26:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262327AbVAQR0k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 12:26:40 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:9647 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S262349AbVAQR0i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 12:26:38 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Thomas Zehetbauer <thomasz@hostmaster.org>
Subject: Re: usb-storage on SMP?
Date: Mon, 17 Jan 2005 18:26:33 +0100
User-Agent: KMail/1.7.1
Cc: lkml <linux-kernel@vger.kernel.org>
References: <1105982247.21895.26.camel@hostmaster.org>
In-Reply-To: <1105982247.21895.26.camel@hostmaster.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501171826.33496.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 17 of January 2005 18:17, Thomas Zehetbauer wrote:
> Hi,
> 
> can anyone confirm that writing to usb-storage devices is working on SMP
> systems?

Generally, it is.  Recently, I've written some stuff to a USB pendrive (using
2.6.10-ac7 or -ac9).

Greets,
RJW


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
