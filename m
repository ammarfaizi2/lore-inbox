Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266003AbUA1Xj2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 18:39:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266224AbUA1Xj1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 18:39:27 -0500
Received: from mail.kroah.org ([65.200.24.183]:7105 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266003AbUA1Xj0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 18:39:26 -0500
Date: Wed, 28 Jan 2004 15:28:44 -0800
From: Greg KH <greg@kroah.com>
To: "Wiran, Francis" <francis.wiran@hp.com>
Cc: Hollis Blanchard <hollisb@us.ibm.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cpqarray update
Message-ID: <20040128232844.GB10657@kroah.com>
References: <CBD6B29E2DA6954FABAC137771769D6504E1596D@cceexc19.americas.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CBD6B29E2DA6954FABAC137771769D6504E1596D@cceexc19.americas.cpqcorp.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 28, 2004 at 05:10:29PM -0600, Wiran, Francis wrote:
> 
> Ok. Here's the patch for that. At least until vio_module_init comes :)

Heh, you didn't actually try that patch, did you?

(hint, you need to check for a negative value...)

greg k-h
