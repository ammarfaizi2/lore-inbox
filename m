Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263818AbUGRMLU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263818AbUGRMLU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jul 2004 08:11:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263824AbUGRMLU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jul 2004 08:11:20 -0400
Received: from web40305.mail.yahoo.com ([66.218.78.84]:24138 "HELO
	web40305.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263818AbUGRMLT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jul 2004 08:11:19 -0400
Message-ID: <20040718121118.49741.qmail@web40305.mail.yahoo.com>
Date: Sun, 18 Jul 2004 05:11:18 -0700 (PDT)
From: Adrian Sandor <aditsu@yahoo.com>
Subject: Re: disabling irq, nobody cared
To: Jan Dittmer <j.dittmer@portrix.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <40FA6230.7030506@portrix.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Jan Dittmer <j.dittmer@portrix.net> wrote:
> I don't have any SATA disk either. Though it did
> make a difference!
> Have you actually tried to change it?

I tried it now, and it indeed made a huge difference!
And the effect was not a big failure to detect the
disks as I expected, but.. the first kernel I tried
(2.6.8-rc1) booted without any noticeable error or
problem! (and windows xp was not affected)

I'm completely baffled about this, and I'm left with
two questions:
1. why?
2. does it have any negative side-effect (e.g. related
to disk transfer performance)?

Thanks a lot!
Adrian


		
__________________________________
Do you Yahoo!?
Vote for the stars of Yahoo!'s next ad campaign!
http://advision.webevents.yahoo.com/yahoo/votelifeengine/

