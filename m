Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261580AbTEDTHO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 May 2003 15:07:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261588AbTEDTHO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 May 2003 15:07:14 -0400
Received: from ws-han1.win-ip.dfn.de ([193.174.75.150]:29133 "EHLO
	ws-han1.win-ip.dfn.de") by vger.kernel.org with ESMTP
	id S261580AbTEDTHN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 May 2003 15:07:13 -0400
Date: Sun, 4 May 2003 21:21:01 +0200
Message-ID: <vines.sxdD+RUKhyA@SZKOM.BFS.DE>
X-Priority: 3 (Normal)
To: <linux-kernel@vger.kernel.org>
From: <WHarms@bfs.de> (Walter Harms)
Reply-To: <WHarms@bfs.de>
Subject: update: fix for pid_t (not-) usage in 2.4.20 
X-Incognito-SN: 25185
X-Incognito-Version: 5.1.0.84
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi list,
here is an update for the pid_t patches more functions
that requiere/use pid_t that needed a quick fix. the 
patches dont change functionality just use the correct type.
why is this important ?
diffrent architectures use different values for pid_t.

download: www.getenv.de/~walter
contact: danielebellucci@libero.it 

	walter
