Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264211AbUFPRAk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264211AbUFPRAk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 13:00:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264192AbUFPRAj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 13:00:39 -0400
Received: from mail.kroah.org ([65.200.24.183]:29141 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264211AbUFPQzd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 12:55:33 -0400
Date: Wed, 16 Jun 2004 09:32:47 -0700
From: Greg KH <greg@kroah.com>
To: Miguelanxo Otero Salgueiro <miguelanxo@telefonica.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.7: ehci_hcd prevents system from suspending properly
Message-ID: <20040616163246.GA8510@kroah.com>
References: <40D07123.1040701@telefonica.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40D07123.1040701@telefonica.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2004 at 06:11:15PM +0200, Miguelanxo Otero Salgueiro wrote:
> I've just compiled 2.6.7 and found that having ehci_hcd loaded (I've 
> compiled it as a module) prevents system from suspending properly. I've 
> got this dmesg messages:

Yeah, known issue, I'm trying to work on it.

thanks,

greg k-h
