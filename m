Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751289AbVIGUDY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751289AbVIGUDY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 16:03:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751294AbVIGUDY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 16:03:24 -0400
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:32204 "EHLO
	ogre.sisk.pl") by vger.kernel.org with ESMTP id S1751289AbVIGUDX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 16:03:23 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: swsusp doesn't suspend devices
Date: Wed, 7 Sep 2005 22:03:18 +0200
User-Agent: KMail/1.8.2
Cc: Pierre Ossman <drzeus-list@drzeus.cx>, Pavel Machek <pavel@ucw.cz>,
       linux-pm@osdl.org
References: <431ECCE3.8080408@drzeus.cx>
In-Reply-To: <431ECCE3.8080408@drzeus.cx>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509072203.19283.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, 7 of September 2005 13:20, Pierre Ossman wrote:
> It would seem that swsusp doesn't properly suspend devices, or more
> precisely it wakes them up again before suspending the machine.

Yes, it does.  By design.

Greetings,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
