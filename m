Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266116AbUALKDr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 05:03:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266123AbUALKDr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 05:03:47 -0500
Received: from nat-pool-surrey.redhat.com ([66.187.227.200]:48729 "EHLO
	gentoo.surrey.redhat.com") by vger.kernel.org with ESMTP
	id S266116AbUALKDq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 05:03:46 -0500
Subject: uk keyboard broken by input updates?
From: Bastien Nocera <hadess@hadess.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1073901824.29420.14.camel@bnocera.surrey.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 12 Jan 2004 10:03:44 +0000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

2.6.1 broke the ~/# key on my UK keyboard, when it used to work fine on
2.6.0. The key is now acting as Print Screen/SysRq. The keyboard is
connected as PS/2 (though it is also plugged as USB, it's a Logitech
wireless keyboard, with the receiver being the same for the mouse and
keyboard).

I didn't look at the changes made to the input layer in details. Could
anyone shed some light on this problem?

Cheers

---
Bastien Nocera <hadess@hadess.net> 
Her voice had that tense, grating quality, like a first-generation
thermal paper fax machine that needed a band tightened. 

