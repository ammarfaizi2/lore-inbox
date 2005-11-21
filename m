Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751121AbVKUWbG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751121AbVKUWbG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 17:31:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751179AbVKUWbG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 17:31:06 -0500
Received: from adsl-67-120-171-161.dsl.lsan03.pacbell.net ([67.120.171.161]:38291
	"HELO linuxace.com") by vger.kernel.org with SMTP id S1751121AbVKUWbE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 17:31:04 -0500
Date: Mon, 21 Nov 2005 14:31:04 -0800
From: Phil Oester <kernel@linuxace.com>
To: David Fox <david.fox@linspire.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-rc2 pci_ids.h cleanup is a pain
Message-ID: <20051121223104.GA6881@linuxace.com>
References: <438249CB.8050200@linspire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <438249CB.8050200@linspire.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2005 at 02:27:23PM -0800, David Fox wrote:
> I'm sure I'm not the only person that applies patches to the kernel that 
> use some of the 500 plus PCI IDS eliminated from pci_ids.h by rc2.  I 
> would like to see the PCI ids that were removed simply because the don't 
> occur in the main kernel source restored.  Is there a rationale for 
> removing them that I'm not aware of?

As long as you are patching the kernel, is there some reason you can't
add back the PCI IDs you require?

Phil
