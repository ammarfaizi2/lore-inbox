Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271121AbTGWHW3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 03:22:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271123AbTGWHW3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 03:22:29 -0400
Received: from tmi.comex.ru ([217.10.33.92]:35042 "EHLO gw.home.net")
	by vger.kernel.org with ESMTP id S271121AbTGWHW3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 03:22:29 -0400
X-Comment-To: Nicholas Miell
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test1 ext3 slab/fs corruption
From: Alex Tomas <bzzz@tmi.comex.ru>
To: Nicholas Miell <nmiell@attbi.com>
Organization: HOME
In-Reply-To: <1058931916.1286.9.camel@entropy> (Nicholas Miell's message of
 "22 Jul 2003 20:45:20 -0700")
User-Agent: Gnus/5.090018 (Oort Gnus v0.18) Emacs/21.3 (gnu/linux)
References: <1058931916.1286.9.camel@entropy>
Date: Wed, 23 Jul 2003 11:37:02 +0000
Message-ID: <8765ltlbj5.fsf@gw.home.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hmm. it really looks like memory problem. have you tried
to test it? all the corruptions happened at the same address.


