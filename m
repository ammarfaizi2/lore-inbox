Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262372AbSI2CXw>; Sat, 28 Sep 2002 22:23:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262373AbSI2CXw>; Sat, 28 Sep 2002 22:23:52 -0400
Received: from ns.suse.de ([213.95.15.193]:11795 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S262372AbSI2CXw>;
	Sat, 28 Sep 2002 22:23:52 -0400
To: John Levon <movement@marcelothewonderpenguin.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] oprofile for 2.5.39
References: <20020929014440.GA66796@compsoc.man.ac.uk.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 29 Sep 2002 04:29:14 +0200
In-Reply-To: John Levon's message of "29 Sep 2002 03:47:59 +0200"
Message-ID: <p737kh5sf45.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Levon <movement@marcelothewonderpenguin.com> writes:

Can you explain what you need the context switch hook for ? 
I don't think it's a good idea to put a hook at such a critical place.
2.4 oprofile worked without such a hook, no ? 

-Andi
