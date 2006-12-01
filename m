Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935226AbWLAHr2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935226AbWLAHr2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 02:47:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935593AbWLAHr2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 02:47:28 -0500
Received: from mail.kroah.org ([69.55.234.183]:15834 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S935226AbWLAHr1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 02:47:27 -0500
Date: Thu, 30 Nov 2006 23:05:52 -0800
From: Greg KH <gregkh@suse.de>
To: Adrian Bunk <bunk@stusta.de>
Cc: geert@linux-m68k.org, zippel@linux-m68k.org,
       David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org,
       linux-m68k@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [RFC: 2.6 patch] don't export device IDs to userspace
Message-ID: <20061201070552.GN16413@suse.de>
References: <20061128012834.GT15364@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061128012834.GT15364@stusta.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2006 at 02:28:34AM +0100, Adrian Bunk wrote:
> I don't see any good reason for exporting device IDs to userspace.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

No objection from me:
	Acked-by: Greg Kroah-Hartman <gregkh@suse.de>
