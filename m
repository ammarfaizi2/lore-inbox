Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261314AbVARPDf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261314AbVARPDf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 10:03:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261315AbVARPDf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 10:03:35 -0500
Received: from kweetal.tue.nl ([131.155.3.6]:59152 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S261314AbVARPDc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 10:03:32 -0500
Date: Tue, 18 Jan 2005 16:03:30 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: "Piszcz, Justin Michael" <justin.piszcz@mitretek.org>
Cc: Mario Holbe <Mario.Holbe@TU-Ilmenau.DE>, linux-kernel@vger.kernel.org
Subject: Re: 2.4: "access beyond end of device" after ext2 mount
Message-ID: <20050118150330.GG8747@pclin040.win.tue.nl>
References: <2E314DE03538984BA5634F12115B3A4E01BC42B3@email1.mitretek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2E314DE03538984BA5634F12115B3A4E01BC42B3@email1.mitretek.org>
User-Agent: Mutt/1.4.2i
X-Spam-DCC: : 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2005 at 09:24:03AM -0500, Piszcz, Justin Michael wrote:

> Is the problem with the drive on the promise board or the drive on the
> VIA chipset?

Oh, please - no FUD. There is no problem, and we understand in detail
what happens and why it happens. There is no need for any speculation.
There is no relation to disk hardware or indeed any hardware.

> Did you check your HDD manual to see if you have
> the 32GB clip enabled?  If so, you need to disable this.
