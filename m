Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269592AbUI3W3t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269592AbUI3W3t (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 18:29:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269598AbUI3W3b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 18:29:31 -0400
Received: from gate.in-addr.de ([212.8.193.158]:36271 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S269591AbUI3W1V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 18:27:21 -0400
Date: Fri, 1 Oct 2004 00:27:12 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: Roland Dreier <roland.list@gmail.com>, Martin Hermanowski <martin@mh57.de>
Cc: linux-thinkpad@linux-thinkpad.org, linux-kernel@vger.kernel.org
Subject: Re: Hard lockup on IBM ThinkPad T42
Message-ID: <20040930222712.GB4607@marowsky-bree.de>
References: <f8ca0a1504093011206230ddea@mail.gmail.com> <20040930205851.GA6911@mh57.de> <f8ca0a1504093014456cf072a1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f8ca0a1504093014456cf072a1@mail.gmail.com>
X-Ctuhulu: HASTUR
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2004-09-30T14:45:48,
   Roland Dreier <roland.list@gmail.com> said:

> > The only thing I noticed is that the hdd-led is constantly on when
> > this happens.
> Interesting... I just had another lockup and my HDD light was
> definitely off.

I'm seeing similar problems on my T30.

Can you confirm that it happens mostly when X has dropped into the
screensaver and tries to come back?


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering
SUSE Labs, Research and Development
SUSE LINUX AG - A Novell company

