Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129336AbQKGTqZ>; Tue, 7 Nov 2000 14:46:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129347AbQKGTqP>; Tue, 7 Nov 2000 14:46:15 -0500
Received: from smtp1.cern.ch ([137.138.128.38]:529 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S129339AbQKGTqF>;
	Tue, 7 Nov 2000 14:46:05 -0500
To: Rick Hohensee <humbubba@smarty.smart.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Fun with namespaces
In-Reply-To: <200011060137.UAA05037@smarty.smart.net>
From: Jes Sorensen <jes@linuxcare.com>
Date: 07 Nov 2000 20:45:57 +0100
In-Reply-To: Rick Hohensee's message of "Sun, 5 Nov 100 20:37:03 -0500 (EST)"
Message-ID: <d3snp3in0q.fsf@lxplus015.cern.ch>
User-Agent: Gnus/5.070096 (Pterodactyl Gnus v0.96) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Rick" == Rick Hohensee <humbubba@smarty.smart.net> writes:

Rick> cLIeNUX Core 1.4 visible dirs in / are all now symlinks. The
Rick> only standard name is /dev. This means if you unpack cLIeNUX
Rick> core on a clean ext2 partition, then install, say, SuSE over it,
Rick> you can boot either one. On the same partition. If you do
Rick> cLIeNUX first the SuSE dev's won't install. I guess. I did this
Rick> with an old SuSE. To boot cLIeNUX you init=/.sbi/init .

This is absolutely great for all three users of clienux. However you
missed an important point, linux-kernel is the Linux *kernel*
development mailing list not a distribution advertisement list. Could
you please move this noise to an appropriate place like
comp.os.linux.announce or .advocacy.

Jes
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
