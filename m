Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964902AbWIKF5K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964902AbWIKF5K (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 01:57:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964901AbWIKF5J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 01:57:09 -0400
Received: from cantor2.suse.de ([195.135.220.15]:35794 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964900AbWIKF5H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 01:57:07 -0400
From: Andi Kleen <ak@suse.de>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: io-apic - no timer ticks after resume on IXP200
Date: Mon, 11 Sep 2006 07:46:58 +0200
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org
References: <20060910141533.GA6594@srcf.ucam.org> <20060910223308.GA1691@elf.ucw.cz> <20060911003129.GA10600@srcf.ucam.org>
In-Reply-To: <20060911003129.GA10600@srcf.ucam.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609110746.58548.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 11 September 2006 02:31, Matthew Garrett wrote:
> (Cc:ing Andi because I seem to remember him reworking the code for this
> chipset)

You forgot to mention on which kernel version you're seeing this?
In particular did it work in some kernel version and then stop in another?

BTW here suspend/resume works fine on a IXP200, so it's something
specific to your board.

-Andi
