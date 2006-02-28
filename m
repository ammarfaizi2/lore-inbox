Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932691AbWB1XlE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932691AbWB1XlE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 18:41:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932686AbWB1XlD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 18:41:03 -0500
Received: from smtp.kam-telecom.ru ([86.109.192.26]:28334 "EHLO
	kt-sv-1.kam-telecom.ru") by vger.kernel.org with ESMTP
	id S932615AbWB1XlB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 18:41:01 -0500
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Feature request: HDD status
Message-Id: <E1FEESA-0002vG-00@porton.narod.ru>
From: "Victor Porton,,," <porton@ex-code.com>
Date: Wed, 01 Mar 2006 04:40:26 +0500
X-URL: http://porton.ex-code.com/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I want the following feature:

Linux would be able (if this is possible for software) to
deliver to the user the state of the HDD, whether it is
active.

I mean that Linux would have a module which would export to
user space a boolean flag (probably a semaphore) which would
be true while the HDD red lamp is shining and false while it
is dark.

That is I want sofrware to provide the same info as this
hadrware HDD indicator on the front panel of most PCs.

(Then a Gnome applet would show it.)

I just look under the table to check HDD status to often
and would instead like to see it on the monitor.

Just a little wish.
