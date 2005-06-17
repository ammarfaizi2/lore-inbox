Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261930AbVFQJyR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261930AbVFQJyR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 05:54:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261933AbVFQJyR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 05:54:17 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:53153 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S261930AbVFQJyP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 05:54:15 -0400
Date: Fri, 17 Jun 2005 13:54:00 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Peter Buckingham <peter@pantasys.com>
Cc: Sean Bruno <sean.bruno@dsl-only.net>,
       Andreas Koch <koch@esa.informatik.tu-darmstadt.de>,
       Linus Torvalds <torvalds@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       gregkh@suse.de
Subject: Re: PROBLEM: Devices behind PCI Express-to-PCI bridge not mapped
Message-ID: <20050617135400.A32290@jurassic.park.msu.ru>
References: <20050605204645.A28422@jurassic.park.msu.ru> <Pine.LNX.4.58.0506091617130.2286@ppc970.osdl.org> <20050610184815.A13999@jurassic.park.msu.ru> <200506102247.30842.koch@esa.informatik.tu-darmstadt.de> <1118762382.9161.3.camel@home-lap> <20050616142039.GF21542@erebor.esa.informatik.tu-darmstadt.de> <42B1B4D3.3060600@pantasys.com> <1118955201.10529.10.camel@home-lap> <42B1E9B2.30504@pantasys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <42B1E9B2.30504@pantasys.com>; from peter@pantasys.com on Thu, Jun 16, 2005 at 02:05:54PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2005 at 02:05:54PM -0700, Peter Buckingham wrote:
> Looking at what I see in our lspci output we get strange values for the 
> bars of the ATI device and the second Nvidia GPU, ie large negative 
> values. The addresses for these devices also look strange and overlap.

What's wrong with these addresses? They are all unique, AFAIKS.

Ivan.
