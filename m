Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262484AbVAEPyq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262484AbVAEPyq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 10:54:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262473AbVAEPxS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 10:53:18 -0500
Received: from orb.pobox.com ([207.8.226.5]:65494 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S262484AbVAEPll (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 10:41:41 -0500
Date: Wed, 5 Jan 2005 07:41:34 -0800
From: "Barry K. Nathan" <barryn@pobox.com>
To: Hubert Tonneau <hubert.tonneau@fullpliant.org>
Cc: Francois Romieu <romieu@fr.zoreil.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.10 TCP troubles
Message-ID: <20050105154134.GB4471@ip68-4-98-123.oc.oc.cox.net>
References: <0508ECY12@server5.heliogroup.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0508ECY12@server5.heliogroup.fr>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 05, 2005 at 12:50:57PM +0000, Hubert Tonneau wrote:
[quote reformatted to fit within 80 columns]
> The problem seems to me to be related to the way the TCP layer is
> handling small troubles (probably lost packets on the Mac side because
> the Linux machine is gigabit connected to the switch, with flow control
> enabled, and the Mac is 100 Mbps connected, full duplex, but without
> flow control).

What OS is the Mac running? If it's Mac OS, then is it Mac OS X or is it
an earlier version?

-Barry K. Nathan <barryn@pobox.com>

