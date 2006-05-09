Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932472AbWEIMXp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932472AbWEIMXp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 08:23:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932479AbWEIMXp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 08:23:45 -0400
Received: from 216-54-166-5.gen.twtelecom.net ([216.54.166.5]:43227 "EHLO
	mx1.compro.net") by vger.kernel.org with ESMTP id S932472AbWEIMXo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 08:23:44 -0400
Message-ID: <446089CF.3050809@compro.net>
Date: Tue, 09 May 2006 08:23:43 -0400
From: Mark Hounschell <markh@compro.net>
Reply-To: markh@compro.net
Organization: Compro Computer Svcs.
User-Agent: Thunderbird 1.5 (X11/20060111)
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: rt20 patch question
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can I assume configuring 'Complete preemption' is the same as
configuring ('Voluntary preemption' + 'Hardirq' + 'Softirq' + default
proc settings)?

Thanks
Mark
