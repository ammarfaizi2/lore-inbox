Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265015AbTIDOVS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 10:21:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265031AbTIDOVS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 10:21:18 -0400
Received: from zork.zork.net ([64.81.246.102]:27847 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id S265015AbTIDOVQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 10:21:16 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: nasm over gas?
References: <20030904104245.GA1823@leto2.endorphin.org>
	<3F5741BD.5000401@mbda.fr> <Pine.LNX.4.53.0309041001090.3367@chaos>
From: Sean Neakums <sneakums@zork.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
Date: Thu, 04 Sep 2003 15:21:14 +0100
In-Reply-To: <Pine.LNX.4.53.0309041001090.3367@chaos> (Richard B. Johnson's
 message of "Thu, 4 Sep 2003 10:05:19 -0400 (EDT)")
Message-ID: <6uiso8r5wl.fsf@zork.zork.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" <root@chaos.analogic.com> writes:

> If you decide to use gcc as a preprocessor, you can't use comments,
> NotGood(tm) because the "#" and some stuff after it gets "interpreted"
> by cpp.

Although one could use C-style comments in this scenario, yes?

-- 
Ah bay tsay day vitamin.
