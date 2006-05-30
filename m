Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932259AbWE3OPX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932259AbWE3OPX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 10:15:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932293AbWE3OPX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 10:15:23 -0400
Received: from mail1.kontent.de ([81.88.34.36]:55721 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S932259AbWE3OPW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 10:15:22 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: zd1201 failure on sharp zaurus explained
Date: Tue, 30 May 2006 16:11:02 +0200
User-Agent: KMail/1.8
Cc: rpurdie@rpsys.net, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>,
       Russell King <rmk@arm.linux.org.uk>,
       Netdev list <netdev@vger.kernel.org>, Jirka Lenost Benc <jbenc@suse.cz>,
       pe1rxq@amsat.org
References: <20060530132054.GA9780@elf.ucw.cz>
In-Reply-To: <20060530132054.GA9780@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605301611.02984.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 30. Mai 2006 15:20 schrieb Pavel Machek:
> 2) usb problem, probably. Should not usb core detect that card
> requires too much juice and refuse to power it up?

Does your hub correctly report whether it is plugged in?

	Regards
		Oliver
