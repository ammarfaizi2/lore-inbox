Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265787AbUF2Psm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265787AbUF2Psm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 11:48:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265789AbUF2Psm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 11:48:42 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:51724 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S265787AbUF2Psl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 11:48:41 -0400
Date: Tue, 29 Jun 2004 16:48:32 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andrey Ulanov <Andrey.Ulanov@acronis.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCMCIA bug fix
Message-ID: <20040629164832.C24951@flint.arm.linux.org.uk>
Mail-Followup-To: Andrey Ulanov <Andrey.Ulanov@acronis.com>,
	linux-kernel@vger.kernel.org
References: <20040629153809.GA6531@dhcp6-7.acronis.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040629153809.GA6531@dhcp6-7.acronis.ru>; from Andrey.Ulanov@acronis.com on Tue, Jun 29, 2004 at 07:38:09PM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 29, 2004 at 07:38:09PM +0400, Andrey Ulanov wrote:
> I tested with one of ieee1394+usb2.0 PCMCIA adapters. Worked fine.
> Without this patch only first device (ieee1394 controller) was
> detected.

Can you provide the lspci output, and a better description of the
problem you're trying to solve please?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
