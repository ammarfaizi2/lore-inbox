Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270666AbTGNPj6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 11:39:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270680AbTGNPj6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 11:39:58 -0400
Received: from probity.mcc.ac.uk ([130.88.200.94]:35335 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP id S270666AbTGNPj5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 11:39:57 -0400
Date: Mon, 14 Jul 2003 16:54:45 +0100
From: John Levon <levon@movementarian.org>
To: torvalds@osdl.org, linux-kernel@vger.kernel.org, ak@suse.de
Cc: oprofile-list@lists.sourceforge.net
Subject: Re: [PATCH] OProfile: dynamically allocate MSR struct
Message-ID: <20030714155445.GA72180@compsoc.man.ac.uk>
References: <20030714151727.GA69617@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030714151727.GA69617@compsoc.man.ac.uk>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: King of Woolworths - L'Illustration Musicale
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *19c5f3-0002CZ-M5*m/ZLReH/OVA*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 14, 2003 at 04:17:28PM +0100, John Levon wrote:

> Andi pointed out to me that cpu_msrs was a source of bloat. Dynamically
> allocate it instead. Tested on my SMP box.

Gah, bogus patch, please ignore.

thanks
john
