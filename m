Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262066AbTD2RDb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 13:03:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262068AbTD2RDb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 13:03:31 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:44520 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262066AbTD2RDb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 13:03:31 -0400
Date: Tue, 29 Apr 2003 10:17:51 -0700
From: Greg KH <greg@kroah.com>
To: Paul Mackerras <paulus@samba.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c-keywest.c irq handler type
Message-ID: <20030429171751.GA7457@kroah.com>
References: <16043.53785.797962.890585@nanango.paulus.ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16043.53785.797962.890585@nanango.paulus.ozlabs.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 27, 2003 at 10:50:33PM +1000, Paul Mackerras wrote:
> This patch changes the interrupt handler routine in i2c-keywest.c to
> return an irqreturn_t.

Applied to my trees.

thanks,

greg k-h
