Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132922AbRD2XaA>; Sun, 29 Apr 2001 19:30:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132895AbRD2X3u>; Sun, 29 Apr 2001 19:29:50 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:61033 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S132881AbRD2X3a>; Sun, 29 Apr 2001 19:29:30 -0400
To: Andrea Arcangeli <andrea@suse.de>
Cc: "Magnus Naeslund(f)" <mag@fbab.net>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Alpha compile problem solved by Andrea (pte_alloc)
In-Reply-To: <052901c0ceca$e6a543c0$020a0a0a@totalmef> <20010427155246.O16020@athlon.random>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 29 Apr 2001 17:27:10 -0600
In-Reply-To: Andrea Arcangeli's message of "Fri, 27 Apr 2001 15:52:46 +0200"
Message-ID: <m1k843qoc1.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Do you know if anyone has fixed the lazy vmalloc code?  I know of
as of early 2.4 it was broken on alpha.  At the time I noticed it I didn't
have time to persue it, but before I forget to even put in a bug
report I thought I'd ask if you know anything about it?

Eric
