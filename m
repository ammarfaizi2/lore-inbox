Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263067AbREWM1z>; Wed, 23 May 2001 08:27:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263069AbREWM1p>; Wed, 23 May 2001 08:27:45 -0400
Received: from t2.redhat.com ([199.183.24.243]:51961 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S263067AbREWM1j>; Wed, 23 May 2001 08:27:39 -0400
To: Andrea Arcangeli <andrea@suse.de>
Cc: eccesys@topmail.de, chris@ludwig-alpha.unil.ch, mblack@csihq.com,
        linux-kernel@vger.kernel.org
Subject: rwsems and asm-constraint gcc bug
Date: Wed, 23 May 2001 13:27:19 +0100
Message-ID: <23545.990620839@warthog.cambridge.redhat.com>
From: David Howells <dhowells@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The bug in gcc 3.0 that stopped the inline asm constraints being interpreted
properly, and thus prevented linux from compiling is now fixed.

David
