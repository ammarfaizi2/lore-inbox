Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261594AbVFZTfu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261594AbVFZTfu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 15:35:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261585AbVFZTfu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 15:35:50 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:6856 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S261594AbVFZTfh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 15:35:37 -0400
Subject: Re: IDE probing IDE_MAX_HWIFS
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Nick Warne <nick@linicks.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200506261908.12398.nick@linicks.net>
References: <200506251210.37623.nick@linicks.net>
	 <1119808271.28644.33.camel@localhost.localdomain>
	 <200506261908.12398.nick@linicks.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1119814384.28649.44.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 26 Jun 2005 20:33:07 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2005-06-26 at 19:08, Nick Warne wrote:
> Heh.  Yes I know now, but I was thinking along the lines that if someone knows 
> how many IDE interfaces they have it could be specified exactly - I 
> didn't/don't see why it is considered an option for config_embedded only to 
> be allowed to do that.

Its a trade off. If you allow every configuration option kernel
configuration begins to resemble an inquisition.

