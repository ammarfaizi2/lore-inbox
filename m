Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261533AbVF0SUy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261533AbVF0SUy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 14:20:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261552AbVF0SUy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 14:20:54 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:44167 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261533AbVF0SUe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 14:20:34 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-mm2: 3ware SATA RAID inaccessible
Date: Mon, 27 Jun 2005 20:20:40 +0200
User-Agent: KMail/1.8.1
Cc: Nick Orlov <bugfixer@list.ru>, akpm@osdl.org
References: <20050626181409.GA4561@nikolas.hn.org>
In-Reply-To: <20050626181409.GA4561@nikolas.hn.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506272020.40607.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, 26 of June 2005 20:14, Nick Orlov wrote:
> 3Ware SATA RAID inaccessible with 2.6.12-mm2:

Confirmed on a dual-Opteron, 64-bit kernel.  I haven't tried 2.6.12-mm1, but the
vanilla 2.6.12 works fine, as well as pre 2.6.12 -mms.

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
