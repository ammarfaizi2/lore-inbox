Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263894AbTFPOo2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 10:44:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263898AbTFPOo2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 10:44:28 -0400
Received: from natsmtp00.webmailer.de ([192.67.198.74]:56243 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP id S263894AbTFPOo2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 10:44:28 -0400
Date: Mon, 16 Jun 2003 16:54:51 +0200
From: Dominik Brodowski <linux@brodo.de>
To: mikpe@csd.uu.se
Cc: Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.71 cardbus problem + possible solution
Message-ID: <20030616145451.GB10636@brodo.de>
References: <16109.50492.555714.813028@gargle.gargle.HOWL> <20030616153253.A13312@flint.arm.linux.org.uk> <16109.54908.249375.482633@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16109.54908.249375.482633@gargle.gargle.HOWL>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 16, 2003 at 04:38:52PM +0200, mikpe@csd.uu.se wrote:
>  > What do people want to do about this?  I have no particular desire to
>  > answer all those emails asking about this, so unless Dominik objects,
>  > I think we should just rename "yenta.c" to "yenta_socket.c" so we have
>  > back-compatibility.

Agreed.

	Dominik
