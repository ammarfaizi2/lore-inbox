Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262767AbUASSSD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 13:18:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262353AbUASSOc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 13:14:32 -0500
Received: from mtaw4.prodigy.net ([64.164.98.52]:23791 "EHLO mtaw4.prodigy.net")
	by vger.kernel.org with ESMTP id S262566AbUASSMw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 13:12:52 -0500
Date: Mon, 19 Jan 2004 10:12:43 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Oliver Kiddle <okiddle@yahoo.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: page allocation failure
Message-ID: <20040119181243.GT1748@srv-lnx2600.matchmail.com>
Mail-Followup-To: Oliver Kiddle <okiddle@yahoo.co.uk>,
	linux-kernel@vger.kernel.org
References: <7641.1074512162@gmcs3.local> <20040119145430.GI1748@srv-lnx2600.matchmail.com> <9759.1074533343@gmcs3.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9759.1074533343@gmcs3.local>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 19, 2004 at 06:29:03PM +0100, Oliver Kiddle wrote:
> could be up before going down. It has gone down twice since I posted
> earlier so it wasn't even vaguely an accurate figure. On both
> occasions, there has not been a "page allocation failure" error though.

Ok, turn on the nmi_watchdog, and see if you get any traces...
