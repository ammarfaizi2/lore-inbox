Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263509AbTIFGEI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Sep 2003 02:04:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262345AbTIFGEI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Sep 2003 02:04:08 -0400
Received: from tmi.comex.ru ([217.10.33.92]:11138 "EHLO gw.home.net")
	by vger.kernel.org with ESMTP id S263509AbTIFGEH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Sep 2003 02:04:07 -0400
X-Comment-To: jw schultz
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] extents support for EXT3
From: Alex Tomas <bzzz@tmi.comex.ru>
To: linux-kernel@vger.kernel.org
Organization: HOME
Date: Sat, 06 Sep 2003 10:09:36 +0400
In-Reply-To: <20030906001919.GE3469@pegasys.ws> (jw schultz's message of
 "Fri, 5 Sep 2003 17:19:19 -0700")
Message-ID: <m3iso6wiqn.fsf@bzzz.home.net>
User-Agent: Gnus/5.090018 (Oort Gnus v0.18) Emacs/21.2 (gnu/linux)
References: <m33cfm19ar.fsf@bzzz.home.net> <20030906001919.GE3469@pegasys.ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> jw schultz (js) writes:

 js> Seems to me that moving to extents offers the perfect
 js> opportunity to eliminate the 1 block limit of extended
 js> attributes.  I don't see any sign of that in this patch but
 js> i might have missed it.

let's wait for Daniel's design paper about shared EAs

