Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751028AbWFLQtX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751028AbWFLQtX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 12:49:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751418AbWFLQtX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 12:49:23 -0400
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:22758
	"EHLO bu3sch.de") by vger.kernel.org with ESMTP id S1751028AbWFLQtX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 12:49:23 -0400
From: Michael Buesch <mb@bu3sch.de>
To: andreas@rittershofer.de
Subject: Re: bcm43xx in 2.6.17-rc6
Date: Mon, 12 Jun 2006 18:49:12 +0200
User-Agent: KMail/1.9.1
References: <1150130676.3820.26.camel@coredump>
In-Reply-To: <1150130676.3820.26.camel@coredump>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606121849.12542.mb@bu3sch.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 12 June 2006 18:44, Andreas Rittershofer wrote:
> 00:0c.0 Network controller: Broadcom Corporation BCM4303 802.11b
> Wireless LAN Controller (rev 02)

bcm43xx is hardly tested on B-only hardware.
Does it work without encryption?

-- 
Greetings Michael.
