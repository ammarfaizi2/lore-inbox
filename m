Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265157AbTFRLqb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 07:46:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265163AbTFRLqb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 07:46:31 -0400
Received: from paloma13.e0k.nbg-hannover.de ([62.181.130.13]:25039 "HELO
	paloma13.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id S265157AbTFRLqa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 07:46:30 -0400
From: Jan-Hinnerk Reichert <jan-hinnerk_reichert@hamburg.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [2.4.21] eth0: Transmit timed out, status fc664010, CSR12 00000000,  resetting...
Date: Wed, 18 Jun 2003 14:00:20 +0200
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200306181400.20837.jan-hinnerk_reichert@hamburg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gerhard Mack wrote:

> This is from dmesg: eth0: ADMtek Comet rev 17 at 0xdc00,
> 00:04:5A:55:FA:12, IRQ 11.
> 
> The card basically becomes *very* slow and fills the logs with:
> NETDEV WATCHDOG: eth0: transmit timed out
> eth0: Transmit timed out, status fc664010, CSR12 00000000, resetting...

Hi,

don't know your card, but I had similar errors on an NE2000-compatible card. 
It was due to a bad coax cable.

 Jan-Hinnerk

