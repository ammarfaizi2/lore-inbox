Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264664AbTD0OHY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Apr 2003 10:07:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264667AbTD0OHY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Apr 2003 10:07:24 -0400
Received: from colin.muc.de ([193.149.48.1]:62480 "HELO colin.muc.de")
	by vger.kernel.org with SMTP id S264664AbTD0OHX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Apr 2003 10:07:23 -0400
Message-ID: <20030427161927.55765@colin.muc.de>
Date: Sun, 27 Apr 2003 16:19:27 +0200
From: Andi Kleen <ak@muc.de>
To: Andi Kleen <ak@muc.de>
Cc: Roman Zippel <zippel@linux-m68k.org>, Andrew Morton <akpm@digeo.com>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] An generic subarchitecture for 2.5.68
References: <20030427012238.GA13997@averell> <20030426231147.69efb07d.akpm@digeo.com> <20030427134217.GA1287@averell> <Pine.LNX.4.44.0304271555530.5042-100000@serv> <20030427160952.25210@colin.muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.88e
In-Reply-To: <20030427160952.25210@colin.muc.de>; from Andi Kleen on Sun, Apr 27, 2003 at 04:09:52PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I made GENERICARCH depend on SMP and it was still defined after an 
> make oldconfig

Never mind. It was a typo on my side.

-Andi
