Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262092AbVD1P5L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262092AbVD1P5L (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 11:57:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262104AbVD1P5L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 11:57:11 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:20461 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S262092AbVD1P5I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 11:57:08 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: RFT: swsusp: more logical register saving order in swsusp
Date: Thu, 28 Apr 2005 17:57:17 +0200
User-Agent: KMail/1.7.1
Cc: kernel list <linux-kernel@vger.kernel.org>
References: <20050428084605.GA27554@elf.ucw.cz>
In-Reply-To: <20050428084605.GA27554@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504281757.17990.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thursday, 28 of April 2005 10:46, Pavel Machek wrote:
> I'd like this to get some testing. It is "obviously correct",
> but... :-).
 
Tested on AMD64.  I have suspended-resumed the box for a couple of times
with the patch applied and it works.

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
