Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267330AbTALIYV>; Sun, 12 Jan 2003 03:24:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267331AbTALIYV>; Sun, 12 Jan 2003 03:24:21 -0500
Received: from cust.7.144.adsl.cistron.nl ([62.216.7.144]:5904 "EHLO sawmill")
	by vger.kernel.org with ESMTP id <S267330AbTALIYU>;
	Sun, 12 Jan 2003 03:24:20 -0500
Date: Sun, 12 Jan 2003 09:28:06 +0100
To: Adrian Bunk <bunk@fs.tum.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] (revised) fix net/irda warnings for 2.4.21-pre3
Message-ID: <20030112082806.GA30849@sawmill>
References: <20030111120432.GA28023@sawmill> <20030112024225.GA28485@sawmill> <20030112072409.GL21826@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030112072409.GL21826@fs.tum.de>
User-Agent: Mutt/1.4i
From: Tony <kernel@mail.vroon.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oh *smacks forehead*

The right .options file would help.
You're right, there were 5 bugs left.

Well, this is my third and final try...

http://www.chainsaw.cistron.nl/compile-fixes-irda.patch.gz


Thanks for the testing, and I hope this one works.

Tony.
