Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274880AbTHFFp7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 01:45:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274881AbTHFFp6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 01:45:58 -0400
Received: from 066-241-084-054.bus.ashlandfiber.net ([66.241.84.54]:896 "EHLO
	bigred.russwhit.org") by vger.kernel.org with ESMTP id S274879AbTHFFp5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 01:45:57 -0400
Date: Tue, 5 Aug 2003 22:43:17 -0700 (PDT)
From: Russell Whitaker <russ@ashlandhome.net>
X-X-Sender: russ@bigred.russwhit.org
To: linux-kernel@vger.kernel.org
Subject: 2.6.0: lp not working
Message-ID: <Pine.LNX.4.53.0308052222560.153@bigred.russwhit.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
Edited lilo.conf so I can boot either kernel-2.6.0-test2
(default) or kernel-2.4.21, using hda1.

lpr a small file, no print. ctrl-alt-del and rebooted using
2.4.21, file printed. Checked the two config files and could
not find any difference in this area.

Printer is a Panasonic dot-matrix running in text mode.
Also using patch bk5.

Thanks,
  Russ
