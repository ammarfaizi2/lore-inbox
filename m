Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266023AbUGEL16@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266023AbUGEL16 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 07:27:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266025AbUGEL16
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 07:27:58 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:13747 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S266023AbUGEL15 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 07:27:57 -0400
Date: Mon, 5 Jul 2004 12:25:21 +0100
From: Dave Jones <davej@redhat.com>
To: David Balazic <david.balazic@hermes.si>
Cc: Matt Domsch <Matt_Domsch@dell.com>, Andries Brouwer <aebr@win.tue.nl>,
       Jeff Garzik <jgarzik@pobox.com>, Pavel Machek <pavel@suse.cz>,
       Linux Kernel <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Weird:  30 sec delay during early boot
Message-ID: <20040705112521.GA18201@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	David Balazic <david.balazic@hermes.si>,
	Matt Domsch <Matt_Domsch@dell.com>,
	Andries Brouwer <aebr@win.tue.nl>, Jeff Garzik <jgarzik@pobox.com>,
	Pavel Machek <pavel@suse.cz>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>
References: <600B91D5E4B8D211A58C00902724252C035F1CB0@piramida.hermes.si>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <600B91D5E4B8D211A58C00902724252C035F1CB0@piramida.hermes.si>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 05, 2004 at 09:21:34AM +0200, David Balazic wrote:
 > Wouldn't the BIOS immediatelly respond with a "no such disk" error if int13
 > would
 > try to access a non-existing disk ?
 > This is BIOS land, not hardware land.

The BIOS guys get their stash from a different dealer to the hardware guys.
Screwups happen. It could just be yet another 'interesting' interpretation
of specifications.

		Dave

