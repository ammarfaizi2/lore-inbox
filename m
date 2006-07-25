Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932443AbWGYQCg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932443AbWGYQCg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 12:02:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964778AbWGYQCg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 12:02:36 -0400
Received: from mx1.redhat.com ([66.187.233.31]:31379 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932440AbWGYQCf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 12:02:35 -0400
Date: Tue, 25 Jul 2006 12:02:07 -0400
From: Alan Cox <alan@redhat.com>
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: sshtylyov@ru.mvista.com, alan@redhat.com, albertcc@tw.ibm.com,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: libata pata_pdc2027x success on sparc64
Message-ID: <20060725160207.GB12318@devserv.devel.redhat.com>
References: <200607190029.k6J0TxrV021572@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607190029.k6J0TxrV021572@harpo.it.uu.se>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2006 at 02:29:59AM +0200, Mikael Pettersson wrote:
> Thank you for these links. After fixing up whitespace damage in
> these four messages the patches applied OK and more importantly
> eliminated _all_ misbehaviour from pdc202xx_new on both my sparc64
> and my PowerMac.
> 
> These fixes belong in Linus' kernel, not some semi-obscure
> mailing list archive.

We've not had an IDE maintainer for some time unfortunately so stuff
got badly lost. I think these and the hpt ones both belong in -mm even if the
longer term goal is to exterminate drivers/ide
