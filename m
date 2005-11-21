Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932479AbVKUXdZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932479AbVKUXdZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 18:33:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932480AbVKUXdZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 18:33:25 -0500
Received: from gate.crashing.org ([63.228.1.57]:61642 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932479AbVKUXdZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 18:33:25 -0500
Subject: Re: [RFC] Small PCI core patch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051121225303.GA19212@kroah.com>
References: <20051121225303.GA19212@kroah.com>
Content-Type: text/plain
Date: Tue, 22 Nov 2005 10:30:59 +1100
Message-Id: <1132615860.26560.58.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-11-21 at 14:53 -0800, Greg KH wrote:
> Any objections to this?

Well, if you're going to make PCI drivers GPL only, I don't see the
point of keeping support for non-GPL modules in the first place :)

Ben.


