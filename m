Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964843AbVLUWeO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964843AbVLUWeO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 17:34:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751192AbVLUWeO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 17:34:14 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:15502 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1751186AbVLUWeM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 17:34:12 -0500
From: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] GIT 1.0.0b quickfix
Date: Wed, 21 Dec 2005 14:34:11 -0800
Message-ID: <7vpsnq3wrg.fsf@assigned-by-dhcp.cox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've pushed out a v1.0.0b maint release to fix a bug in HTTP
fetch that was discovered today X-<.

