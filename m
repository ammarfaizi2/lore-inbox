Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262047AbVC1UHb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262047AbVC1UHb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 15:07:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262056AbVC1UHb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 15:07:31 -0500
Received: from graphe.net ([209.204.138.32]:45842 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S262047AbVC1UH3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 15:07:29 -0500
Date: Mon, 28 Mar 2005 12:07:27 -0800 (PST)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@server.graphe.net
To: Oleg Nesterov <oleg@tv-sign.ru>
cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH rc1-mm3] timers: simplify locking
In-Reply-To: <424835D5.99FDB1D5@tv-sign.ru>
Message-ID: <Pine.LNX.4.58.0503281206390.27734@server.graphe.net>
References: <424835D5.99FDB1D5@tv-sign.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok. Testing with your latest and greatest patches. Is there any
clarity about what caused the hangs?

