Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030480AbVKCVAx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030480AbVKCVAx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 16:00:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030479AbVKCVAx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 16:00:53 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:26503
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1030480AbVKCVAw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 16:00:52 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Roland Dreier <rolandd@cisco.com>
Subject: Re: initramfs for /dev/console with udev?
Date: Thu, 3 Nov 2005 15:00:33 -0600
User-Agent: KMail/1.8
Cc: Robert Schwebel <r.schwebel@pengutronix.de>, linux-kernel@vger.kernel.org
References: <20051102222030.GP23316@pengutronix.de> <200511031313.47820.rob@landley.net> <52mzkl4i8y.fsf@cisco.com>
In-Reply-To: <52mzkl4i8y.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511031500.34264.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 03 November 2005 13:57, Roland Dreier wrote:
>  > On Thursday 03 November 2005 12:51, Robert Schwebel wrote:
>  > > [...] klibc didn't compile for ARCH=um.
>  >
>  > I repeat my question: what is it that didn't compile, klibc or the
>  > kernel?
>
> come on, dude -- how much clearer can he be?

How do you feed ARCH=um to klibc?

Rob
