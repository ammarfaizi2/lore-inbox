Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932210AbVIRV1X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932210AbVIRV1X (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 17:27:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932211AbVIRV1X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 17:27:23 -0400
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:8865 "EHLO
	ogre.sisk.pl") by vger.kernel.org with ESMTP id S932210AbVIRV1X
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 17:27:23 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Grzegorz Piotr Jaskiewicz <gj@kdemail.net>
Subject: Re: dell's latitude cdburner problem
Date: Sun, 18 Sep 2005 23:27:23 +0200
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
References: <200509182257.23363@gj-laptop>
In-Reply-To: <200509182257.23363@gj-laptop>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509182327.24290.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sunday, 18 of September 2005 22:57, Grzegorz Piotr Jaskiewicz wrote:
> Hi folks
> 
> I don't know whether this is linuxes cdrecord issue, or kernel issue.
> I have dell latitude c640 laptop with their's dvd/cd-rw combo drive that 
> appears as:
> hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache
> 
> Trouble is, that this drive suppose to write CDs at 24x, and does so under 
> windows. But under Linux it works only 8x. Anyone with the same problem 
> please?

Same on Asus L5D x86-64 with Toshiba SD-R2512, and k3b and I have seen it
for a couple of times on different notebooks.  I don't consider it as a big issue,
though.

Greetings,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
