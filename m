Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261623AbVA3BDY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261623AbVA3BDY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 20:03:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261622AbVA3BDY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 20:03:24 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:14061 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261625AbVA3BCf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 20:02:35 -0500
Date: Sat, 29 Jan 2005 14:26:32 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: James Nelson <james4765@cwazy.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.4] lcd: fix memory leak in lcd_ioctl()
Message-ID: <20050129162632.GA2983@logos.cnet>
References: <20050128002501.23839.78981.57374@localhost.localdomain> <20050128002508.23839.95066.57216@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050128002508.23839.95066.57216@localhost.localdomain>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Applied both, thanks James.

On Thu, Jan 27, 2005 at 06:25:09PM -0600, James Nelson wrote:
> This patch fixes a memory leak in the FLASH_Burn ioctl for the Cobalt LCD interface driver.
> 
> Signed-off-by: James Nelson <james4765@gmail.com>
