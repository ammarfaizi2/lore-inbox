Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261959AbVFQN0R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261959AbVFQN0R (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 09:26:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261966AbVFQN0R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 09:26:17 -0400
Received: from oldconomy.demon.nl ([212.238.217.56]:24528 "EHLO
	artemis.slagter.name") by vger.kernel.org with ESMTP
	id S261959AbVFQN0K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 09:26:10 -0400
Subject: Re: Inspiron 6000 / ACPI S3 / PCI-X problems?
From: Erik Slagter <erik@slagter.name>
To: Mark Lord <lkml@rtr.ca>
Cc: "Michael (Micksa) Slade" <micksa@knobbits.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <42A6B7B8.90000@rtr.ca>
References: <42A4969D.9070500@knobbits.org>  <42A6B7B8.90000@rtr.ca>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 17 Jun 2005 15:25:24 +0200
Message-Id: <1119014724.5396.44.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-8) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-06-08 at 05:17 -0400, Mark Lord wrote:
> The i6000 is very similar internally (identical?) to the i9300.
> I have a Dell Inspiron 9300 and *everything* is working perfectly with Linux,
> except for the SD-slot (no driver, no datasheets).

Same here. Make sure you suspend from within X, this seems to be
"better".
