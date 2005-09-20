Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964932AbVITIpL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964932AbVITIpL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 04:45:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964934AbVITIpL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 04:45:11 -0400
Received: from ncc1701.cistron.net ([62.216.30.38]:33692 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP id S964932AbVITIpK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 04:45:10 -0400
From: dth@cistron.nl (Danny ter Haar)
Subject: Re: 2.6.14-rc1-git5: problem with "nosmp" boot argument
Date: Tue, 20 Sep 2005 08:45:09 +0000 (UTC)
Organization: Cistron
Message-ID: <dgoi6l$34t$1@news.cistron.nl>
References: <dgohe2$2iv$1@news.cistron.nl>
X-Trace: ncc1701.cistron.net 1127205909 3229 62.216.30.70 (20 Sep 2005 08:45:09 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: dth@cistron.nl (Danny ter Haar)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Danny ter Haar <dth@cistron.nl> wrote:
>Just tried to reboot SMP kernel with "nosmp" argument.
>testing NMI watchdog ... CPU#0: NMI appears to be stuck (0->0)!

Couldn't post it on bugzilla.kernel.org since that one is down.

"Bugzilla is currently broken. Please try again later. If the problem
persists, please contact bugme-admin@osdl.org.+The error you should
quote is: Can't connect to MySQL server on 'nat.osdl.org' (113) at
globals.pl line 140."

kernel config is @ http://newsgate.newsserver.nl/kernel/

Danny



