Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129777AbQKUPX4>; Tue, 21 Nov 2000 10:23:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130465AbQKUPXq>; Tue, 21 Nov 2000 10:23:46 -0500
Received: from smtp1.cern.ch ([137.138.128.38]:27913 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S129777AbQKUPXa>;
	Tue, 21 Nov 2000 10:23:30 -0500
To: elenstev@mesatop.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] CONFIG_TOSHIBA Configure.help for 2.4.0-test11
In-Reply-To: <00112018440600.00911@localhost.localdomain>
From: Jes Sorensen <jes@linuxcare.com>
Date: 21 Nov 2000 15:53:21 +0100
In-Reply-To: Steven Cole's message of "Mon, 20 Nov 2000 18:44:06 -0700"
Message-ID: <d37l5xbcm6.fsf@lxplus015.cern.ch>
User-Agent: Gnus/5.070096 (Pterodactyl Gnus v0.96) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Steven" == Steven Cole <elenstev@mesatop.com> writes:

Steven> I noticed that for 2.4.0-test11 there is no help for
Steven> CONFIG_TOSHIBA, although there is for 2.2.17.

Steven> The following patch borrows the words for CONFIG_TOSHIBA from
Steven> the 2.2.17 Documentation/Configure.help, dropping an
Steven> extraneous "the" from the first line.

Would probably be a good idea to name the config option
CONFIG_TOSHIBA_LAPTOP_MGMT or something to avoid the possibility of a
conflict in case someone else special cases some other Toshiba thing.

Jes
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
