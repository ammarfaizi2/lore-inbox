Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262319AbUKQNaD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262319AbUKQNaD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 08:30:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262316AbUKQN2y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 08:28:54 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:35287 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262314AbUKQN2w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 08:28:52 -0500
Date: Wed, 17 Nov 2004 07:22:53 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Atro.Tossavainen@helsinki.fi
Cc: linux-kernel@vger.kernel.org, mikem@beardog.cca.cpqcorp.net
Subject: Re: 2.4.27 and CCISS related problem
Message-ID: <20041117092208.GA20093@logos.cnet>
References: <20041117064727.GD19107@logos.cnet> <200411171132.iAHBWEhH009305@kruuna.Helsinki.FI>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411171132.iAHBWEhH009305@kruuna.Helsinki.FI>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2004 at 01:32:14PM +0200, Atro Tossavainen wrote:
> > Please try vanilla v2.4.27.
> 
> Freezes as before.
> 
> > If that doesnt work, go down to v2.4.26.
> 
> Doesn't freeze.

Mike, something in v2.4.27 cciss changes are causing Atro's 
problems.

Can you take care of it please?
