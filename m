Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262368AbTFOQgo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 12:36:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262382AbTFOQgn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 12:36:43 -0400
Received: from clem.clem-digital.net ([68.16.168.10]:49934 "EHLO
	clem.clem-digital.net") by vger.kernel.org with ESMTP
	id S262368AbTFOQgl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 12:36:41 -0400
From: Pete Clements <clem@clem.clem-digital.net>
Message-Id: <200306151650.MAA05807@clem.clem-digital.net>
Subject: Re: 2.5.71 -- Lost second 3c509 card
In-Reply-To: <1055693991.7678.0.camel@rth.ninka.net> from "David S. Miller" at "Jun 15, 2003  9:19:51 am"
To: davem@redhat.com (David S. Miller)
Date: Sun, 15 Jun 2003 12:50:25 -0400 (EDT)
Cc: clem@clem.clem-digital.net, linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL48 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting David S. Miller
  > On Sun, 2003-06-15 at 06:19, Pete Clements wrote:
  > > As a followup, reverted the 3c509 bk10 changes. Back in business
  > > with 2.5.71.
  > 
  > Are you using command line port number specifications?
  > If so, what do they look like?
  > 
  > -- 
  > David S. Miller <davem@redhat.com>
  > 

>From boot log:

Kernel command line: auto BOOT_IMAGE=Linux ro root=341 ether=9,0x310,4,0x3c509,eth1
-- 
Pete Clements 
clem@clem.clem-digital.net
