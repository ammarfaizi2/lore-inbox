Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263810AbTKXRiE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 12:38:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263812AbTKXRiD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 12:38:03 -0500
Received: from ss1000.ms.mff.cuni.cz ([195.113.19.221]:29642 "EHLO
	ss1000.ms.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S263810AbTKXRiC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 12:38:02 -0500
Date: Mon, 24 Nov 2003 18:37:57 +0100
From: Rudo Thomas <thomr9am@ss1000.ms.mff.cuni.cz>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Jakob Lell <jlell@JakobLell.de>, linux-kernel@vger.kernel.org
Subject: Re: hard links create local DoS vulnerability and security problems
Message-ID: <20031124183757.A2507@ss1000.ms.mff.cuni.cz>
Mail-Followup-To: "Richard B. Johnson" <root@chaos.analogic.com>,
	Jakob Lell <jlell@JakobLell.de>, linux-kernel@vger.kernel.org
References: <200311241736.23824.jlell@JakobLell.de> <Pine.LNX.4.53.0311241205500.18425@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.53.0311241205500.18425@chaos>; from root@chaos.analogic.com on Mon, Nov 24, 2003 at 12:14:34PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> A setuid binary created with a hard-link will only work as a setuid
> binary if the directory it's in is owned by root. [...]

This is not true, just verified it.

Rudo.
