Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265760AbTIJVUp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 17:20:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265761AbTIJVUp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 17:20:45 -0400
Received: from gprs147-211.eurotel.cz ([160.218.147.211]:1152 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S265760AbTIJVUo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 17:20:44 -0400
Date: Wed, 10 Sep 2003 22:49:43 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Pavel Machek <pavel@ucw.cz>
Cc: Patrick Mochel <mochel@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: What happened to SUSPEND_SAVE_STATE?
Message-ID: <20030910204940.GA11571@elf.ucw.cz>
References: <20030910201124.GA11449@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030910201124.GA11449@elf.ucw.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> What happened to SUSPEND_SAVE_STATE?

SUSPEND_NOTIFY seems dead, too. Should I simply ignore level parameter
in pcmcia_socket_dev_suspend?
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
