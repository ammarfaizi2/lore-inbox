Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264798AbUFYMZr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264798AbUFYMZr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 08:25:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265545AbUFYMZr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 08:25:47 -0400
Received: from zork.zork.net ([64.81.246.102]:52897 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id S264798AbUFYMZq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 08:25:46 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: Collapse ext2 and 3 please
References: <40DB605D.6000409@comcast.net>
From: Sean Neakums <sneakums@zork.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
Date: Fri, 25 Jun 2004 13:25:46 +0100
In-Reply-To: <40DB605D.6000409@comcast.net> (John Richard Moser's message of
	"Thu, 24 Jun 2004 19:14:37 -0400")
Message-ID: <6uhdsz3jud.fsf@zork.zork.net>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: sneakums@zork.net
X-SA-Exim-Scanned: No (on zork.zork.net); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I seem to remember somebody, I think maybe Andrew Morton, suggesting
that a no-journal mode be added to ext3 so that ext2 could be removed.
I can't find the message in question right now, though.
