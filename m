Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932143AbVLIL1c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932143AbVLIL1c (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 06:27:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932149AbVLIL1c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 06:27:32 -0500
Received: from host213-160-108-25.dsl.vispa.com ([213.160.108.25]:56767 "EHLO
	orac.home") by vger.kernel.org with ESMTP id S932143AbVLIL1a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 06:27:30 -0500
From: Andrew Walrond <andrew@walrond.org>
To: linux-kernel@vger.kernel.org
Subject: Machine check exception logging
Date: Fri, 9 Dec 2005 11:27:22 +0000
User-Agent: KMail/1.8.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512091127.23016.andrew@walrond.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just got three of these in the kernel ring buffer, (simultaneous with 
something weird happening):

	Machine check events logged
	Machine check events logged
	Machine check events logged

Logged where?

I seem to remember there being a daemon that grabs and logs these, but don't 
remember what it is. Google didn't help.

Can anyone enlighten me?

Andrew Walrond
