Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266546AbTGHD7p (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 23:59:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266620AbTGHD7p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 23:59:45 -0400
Received: from web14008.mail.yahoo.com ([216.136.175.124]:39687 "HELO
	web14008.mail.yahoo.com") by vger.kernel.org with SMTP
	id S266546AbTGHD7o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 23:59:44 -0400
Message-ID: <20030708041419.8239.qmail@web14008.mail.yahoo.com>
Date: Mon, 7 Jul 2003 21:14:19 -0700 (PDT)
From: Matt Hartley <matthartley@yahoo.com>
Subject: Re: Linux 2.4.22-pre3-ac1
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm looking at the new Cryptographic options that were merged into this
kernel, and don't see any options for "crytoloop" mounting of encrypted
files as loop-back filesytems like the ones that I've been using in the
CryptoAPI patches.  

Are any additional patches needed for this, and if so, are there plans
to merge them at any point?  These seem focused mostly on IPsec from
what I can tell, hence my confusion, and the CryptoAPI patches
obviously don't patch in cleanly anymore.

Thanks in advance for the help!
Matt Hartley

__________________________________
Do you Yahoo!?
SBC Yahoo! DSL - Now only $29.95 per month!
http://sbc.yahoo.com
