Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932525AbVLMHdW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932525AbVLMHdW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 02:33:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932528AbVLMHdW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 02:33:22 -0500
Received: from mail.kroah.org ([69.55.234.183]:53727 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932525AbVLMHdV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 02:33:21 -0500
Date: Mon, 12 Dec 2005 23:29:12 -0800
From: Greg KH <greg@kroah.com>
To: Michael Krufky <mkrufky@gmail.com>
Cc: stable@kernel.org, Mauro Carvalho Chehab <mchehab@brturbo.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [stable] [STABLE PATCH] V4L/DVB: Fix analog NTSC for Thomson DTT 761X hybrid tuner
Message-ID: <20051213072912.GC5056@kroah.com>
References: <43991E34.60503@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43991E34.60503@gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 09, 2005 at 01:03:32AM -0500, Michael Krufky wrote:
> The following bugfix is already in 2.6.15-git1.  Please queue this up 
> for 2.6.14.4

queued to -stable, thanks.

greg k-h
