Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276477AbRKVKkl>; Thu, 22 Nov 2001 05:40:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277024AbRKVKkb>; Thu, 22 Nov 2001 05:40:31 -0500
Received: from [194.213.32.133] ([194.213.32.133]:33665 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S276477AbRKVKk1>;
	Thu, 22 Nov 2001 05:40:27 -0500
Date: Wed, 21 Nov 2001 22:05:44 +0100
From: Pavel Machek <pavel@suse.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: Disabling FPU, MMX, SSE units?
Message-ID: <20011121220544.A7357@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Is there way not to let linux use FPU, MMX, SSE and similar fancy
units? I have athlon processor, but would like to turn FPU (and
similar fancy stuff) off...
							Pavel
PS: I'm trying to narrow down sigsegv-after-resume problem... Getting
rid of fancy 486+ features would help me.
-- 
<sig in construction>
