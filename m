Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262209AbVBKXSn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262209AbVBKXSn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 18:18:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262259AbVBKXSn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 18:18:43 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:27663 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262209AbVBKXSl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 18:18:41 -0500
Date: Fri, 11 Feb 2005 23:18:30 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Bjorn Helgaas <bjorn-helgaas@comcast.net>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [SERIAL] add TP560 data/fax/modem support
Message-ID: <20050211231830.A1821@flint.arm.linux.org.uk>
Mail-Followup-To: Bjorn Helgaas <bjorn-helgaas@comcast.net>,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1107805182.8074.35.camel@piglet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1107805182.8074.35.camel@piglet>; from bjorn-helgaas@comcast.net on Mon, Feb 07, 2005 at 12:39:42PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2005 at 12:39:42PM -0700, Bjorn Helgaas wrote:
> Claim Topic TP560 data/fax/voice modem.  This device reports as class 0x0780,
> so we don't claim it by default:

Applied, thanks.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
