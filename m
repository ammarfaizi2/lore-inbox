Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261592AbVAXTsM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261592AbVAXTsM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 14:48:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261588AbVAXTsM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 14:48:12 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:45208 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261592AbVAXToS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 14:44:18 -0500
Message-ID: <41F54FC1.6080207@pobox.com>
Date: Mon, 24 Jan 2005 14:42:57 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
CC: Matthew Wilcox <matthew@wil.cx>, Jesse Barnes <jbarnes@sgi.com>,
       linux-pci@atrey.karlin.mff.cuni.cz, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Fwd: Patch to control VGA bus routing and active VGA device.
References: <9e47339105011719436a9e5038@mail.gmail.com>	 <41ED3BD2.1090105@pobox.com>	 <9e473391050122083822a7f81c@mail.gmail.com>	 <200501240847.51208.jbarnes@sgi.com>	 <20050124175131.GM31455@parcelfarce.linux.theplanet.co.uk> <9e473391050124111767a9c6b7@mail.gmail.com>
In-Reply-To: <9e473391050124111767a9c6b7@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Smirl wrote:
> Is this a justification for doing device drivers for bridge chips? It
> has been mentioned before but no one has done it.


Yeah, people are usually slack and work around the problem.

A bridge driver is really wanted for several situations in today's 
hardware...

	Jeff


