Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264258AbUGFSi7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264258AbUGFSi7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 14:38:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264265AbUGFSi7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 14:38:59 -0400
Received: from sb0-cf9a48a7.dsl.impulse.net ([207.154.72.167]:19662 "EHLO
	madrabbit.org") by vger.kernel.org with ESMTP id S264258AbUGFSi6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 14:38:58 -0400
Subject: Re: post 2.6.7 BK change breaks Java?
From: Ray Lee <ray-lk@madrabbit.org>
To: matthias.andree@gmx.de
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: http://madrabbit.org/
Message-Id: <1089139137.4373.33.camel@orca.madrabbit.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 06 Jul 2004 11:38:57 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> BTW, how do I tell BitKeeper "pull up to revision..."? bk pull and bk
> undo -aREV is a way, but it's wasteful.

Don't pull to a version. Pull the latest, keep it, and get or export
different versions instead:

	bk -r get -q -rREV

...Or Incantations To That Effect.

Ray

