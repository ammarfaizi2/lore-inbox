Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261363AbULTArH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261363AbULTArH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Dec 2004 19:47:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261365AbULTArH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Dec 2004 19:47:07 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:51901 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261363AbULTArD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Dec 2004 19:47:03 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Ari Pollak <aripollak@gmail.com>
Subject: Re: 2.6.10-rc3-mm1: swsusp
Date: Mon, 20 Dec 2004 01:47:00 +0100
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
References: <200412181852.31942.rjw@sisk.pl> <cq50gt$ppc$1@sea.gmane.org>
In-Reply-To: <cq50gt$ppc$1@sea.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412200147.00859.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 19 of December 2004 23:48, Ari Pollak wrote:
> Rafael J. Wysocki wrote:
> > Still, unfortunately, today it crashed on suspend and I wasn't able to get 
any 
> > useful information related to the crash,
> 
> Have you tried an -rc3-bk13 snapshot? Some changes went in related to 
> ALSA drivers and swsusp/ACPI suspend, perhaps it will fix the problem.

Unfortunately, I have no time for playing with -bk kernels.  I'll wait for 
-rc4 or 2.6.10 or maybe Andrew will include this fixes into -mm before?

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
