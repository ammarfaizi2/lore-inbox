Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261746AbUKCSKn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261746AbUKCSKn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 13:10:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261785AbUKCSKn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 13:10:43 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:56466 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261746AbUKCSKk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 13:10:40 -0500
Date: Wed, 3 Nov 2004 13:09:47 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Jim Nelson <james4765@verizon.net>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH 5/5] documentation: Remove drivers/char/README.cycladesZ
Message-ID: <20041103150947.GA4695@logos.cnet>
References: <20041103152246.24869.2759.68945@localhost.localdomain> <20041103152314.24869.56459.88722@localhost.localdomain> <20041103133103.GB4109@logos.cnet> <41891AF3.9050800@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41891AF3.9050800@verizon.net>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 03, 2004 at 12:52:51PM -0500, Jim Nelson wrote:
> You're right.  I'll send a patch to put README.cycladesZ in 
> Documentation/serial right now.

Also please only remove other README's if they are really obsolete. 
Whats your criteria for choosing what is obsolete?

Move the rest to Documentation/serial, fine.
