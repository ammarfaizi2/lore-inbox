Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261772AbVEDNSZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261772AbVEDNSZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 09:18:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261795AbVEDNSZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 09:18:25 -0400
Received: from cantor2.suse.de ([195.135.220.15]:48531 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261772AbVEDNSX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 09:18:23 -0400
Date: Wed, 4 May 2005 15:18:22 +0200
From: Andi Kleen <ak@suse.de>
To: YhLu <YhLu@tyan.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: x86-64 dual core mapping
Message-ID: <20050504131822.GD1174@wotan.suse.de>
References: <3174569B9743D511922F00A0C943142309B07D82@TYANWEB>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3174569B9743D511922F00A0C943142309B07D82@TYANWEB>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 03, 2005 at 05:18:15PM -0700, YhLu wrote:
> Andi,
> 
> Did you try "acpi=off" on you test?

numa=noacpi yes which is equivalent.

Please wait until after the tree resync with this.

-Andi
