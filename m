Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273646AbRIWOcQ>; Sun, 23 Sep 2001 10:32:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273644AbRIWOb4>; Sun, 23 Sep 2001 10:31:56 -0400
Received: from [195.223.140.107] ([195.223.140.107]:47867 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S273646AbRIWOby>;
	Sun, 23 Sep 2001 10:31:54 -0400
Date: Sun, 23 Sep 2001 16:32:21 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Benjamin LaHaise <bcrl@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.10pre13aa1
Message-ID: <20010923163221.B727@athlon.random>
In-Reply-To: <3BADAF6A.8090400@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BADAF6A.8090400@colorfullife.com>; from manfred@colorfullife.com on Sun, Sep 23, 2001 at 11:46:18AM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 23, 2001 at 11:46:18AM +0200, Manfred Spraul wrote:
> I'd prefer ptep_get_and_clear_and_flush(), then the arch part can do

agreed. In the meantime I'll just keep the assert.

Andrea
