Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751321AbVKAWFF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751321AbVKAWFF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 17:05:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751335AbVKAWFF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 17:05:05 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:21166
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1751321AbVKAWFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 17:05:04 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: "Jeff V. Merkey" <jmerkey@utah-nac.org>
Subject: Re: Would I be violating the GPL?
Date: Tue, 1 Nov 2005 16:04:53 -0600
User-Agent: KMail/1.8
Cc: Michael Buesch <mbuesch@freenet.de>, alex@alexfisher.me.uk,
       linux-kernel@vger.kernel.org
References: <5449aac20511010949x5d96c7e0meee4d76a67a06c01@mail.gmail.com> <200511012000.21176.mbuesch@freenet.de> <4367A990.2040301@utah-nac.org>
In-Reply-To: <4367A990.2040301@utah-nac.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511011604.54317.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 01 November 2005 11:44, Jeff V. Merkey wrote:
> No, don't take the code without the suppliers permission.  It contains
> trade secrets and you can get into a ot of trouble if there's an
> agreement between the two of you.  Contact the supplier.  Tell them to
> abstract away thre kernel headers, or rewrite to remove them, or grant
> you persmission to open source the driver.  The UK is the land of
> frivilous lawsuits (I should know a lot about this :-)  ), so don;t
> expose yourself and breach any agreements.
>
> Jeff

Translation to what a sane person might have said:

Make sure you aren't bound by any non-disclosure agreements before posting a 
driver specification for public viewing.  Writing up such a spec from the 
source code (if the supplier didn't give you one) is probably a darn good 
idea either way, for your own internal maintenance purposes.  If you have the 
spare cycles...

Rob
