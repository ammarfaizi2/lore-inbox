Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264258AbUFBV2e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264258AbUFBV2e (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 17:28:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264223AbUFBV2d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 17:28:33 -0400
Received: from mx1.redhat.com ([66.187.233.31]:25479 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264239AbUFBV1f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 17:27:35 -0400
Date: Wed, 2 Jun 2004 17:26:23 -0400
From: Alan Cox <alan@redhat.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: PATCH: Submission of via "velocity(tm)" series adapter driver
Message-ID: <20040602212623.GA13285@devserv.devel.redhat.com>
References: <20040602201315.GA10339@devserv.devel.redhat.com> <40BE3F00.4090408@pobox.com> <20040602211646.GA9419@devserv.devel.redhat.com> <40BE458D.4050408@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40BE458D.4050408@pobox.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02, 2004 at 05:24:29PM -0400, Jeff Garzik wrote:
> Alan Cox wrote:
> >Most of our drivers don't work bigendian. If you want it bigendian you
> 
> As an additional rebuttal, most of the PCI drivers people care about do 
> work on big-endian...

This one probably does, but if not then either

a) Someone fixes it or
b) It gets merged anyway and the other 99.99999% of the user base don't have
   to suffer in the meantime.

I really don't care. I'm sure all the vendors can merge it directly.

