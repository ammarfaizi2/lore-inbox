Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264727AbUDVXQw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264727AbUDVXQw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 19:16:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264729AbUDVXQw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 19:16:52 -0400
Received: from mail07b.vwh1.net ([207.201.152.67]:30338 "HELO mail07b.vwh1.net")
	by vger.kernel.org with SMTP id S264727AbUDVXQu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 19:16:50 -0400
From: Nick Popoff <cryptic-lkml@bloodletting.com>
To: Anton Blanchard <anton@samba.org>, linux-kernel@vger.kernel.org
Subject: Re: Testing Dual Ethernet via Loopback
Date: Thu, 22 Apr 2004 04:08:59 -0700
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404220408.59399.cryptic-lkml@bloodletting.com>
X-Loop-Detect: 1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 23 Apr 2004, Anton Blanchard wrote:
> Sounds like you need the send-to-self patch:
> http://www.ssi.bg/~ja/
> We've been using it a lot in the lab, it works well.

I tried this out yesterday with Linux 2.6.5 at it worked like a charm.  Thank 
you to everyone who replied with solutions and to the author of this patch!  

I thought the idea of pinging an invalid IP from one interface while snooping 
with ethereal on the other interface was very clever, but hard to use for 
performance testing. :-)




