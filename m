Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261612AbTIYSQg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 14:16:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261458AbTIYSPc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 14:15:32 -0400
Received: from smtp1.fre.skanova.net ([195.67.227.94]:25054 "EHLO
	smtp1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S261326AbTIYSNz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 14:13:55 -0400
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: akpm@osdl.org, dtor_core@ameritech.net, Andries.Brouwer@cwi.nl,
       linux-kernel@vger.kernel.org
Subject: Re: My current patches
References: <20030925164845.GA30105@ucw.cz>
From: Peter Osterlund <petero2@telia.com>
Date: 25 Sep 2003 20:13:43 +0200
In-Reply-To: <20030925164845.GA30105@ucw.cz>
Message-ID: <m2zngsg2i0.fsf@p4.localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik <vojtech@suse.cz> writes:

> I'm sending you my current set of patches for review and testing.
> Please forward to whoever can test them. If no problems are found, I'll
> be sending them to Linus for inclusion in 2.6 tomorrow or so.

I tried this patch set on my Clevo laptop and the touchpad is working
fine. The patch set also fixes keyboard problems that I started seeing
a few days ago. (Very slow auto repeat and randomly stuck CTRL key.)

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
