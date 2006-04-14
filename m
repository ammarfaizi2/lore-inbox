Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932272AbWDNLoT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932272AbWDNLoT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 07:44:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932283AbWDNLoT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 07:44:19 -0400
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:49071
	"EHLO bu3sch.de") by vger.kernel.org with ESMTP id S932272AbWDNLoS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 07:44:18 -0400
From: Michael Buesch <mb@bu3sch.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Current linus git bcm4xxx broken for me
Date: Fri, 14 Apr 2006 13:43:04 +0200
User-Agent: KMail/1.9.1
References: <1144972957.5006.2.camel@localhost.localdomain>
In-Reply-To: <1144972957.5006.2.camel@localhost.localdomain>
Cc: bcm43xx-dev@lists.berlios.de,
       Linux Kernel list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604141343.05053.mb@bu3sch.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 14 April 2006 02:02, Benjamin Herrenschmidt wrote:
> I get that with current upstream git :
> 
> [   34.127738] bcm43xx: Chip ID 0x4318, rev 0x2
                                  ^^^^^^
                                  known broken
We work at it.

-- 
Greetings Michael.
