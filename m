Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273680AbRIWWy0>; Sun, 23 Sep 2001 18:54:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273682AbRIWWyQ>; Sun, 23 Sep 2001 18:54:16 -0400
Received: from mail.eunet.ch ([146.228.10.7]:52497 "EHLO mail.kpnqwest.ch")
	by vger.kernel.org with ESMTP id <S273680AbRIWWyJ>;
	Sun, 23 Sep 2001 18:54:09 -0400
Message-ID: <3BAE843B.21F54120@dial.eunet.ch>
Date: Mon, 24 Sep 2001 00:54:19 +0000
From: Mario Vanoni <vanonim@dial.eunet.ch>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: 2.4.10: 3c59x: buggy?
In-Reply-To: <3BACF2E7.3AFC201E@dial.eunet.ch> <3BACEFD5.6EB51CA3@zip.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.10 works on a SMP and an UP perfectly,
except the ethernet with 3C905 COMBO.

UP:  works with or without enabled modules.

SMP: works _only_ with modularized kernel,
     only needed module: 3c59x.

Regards

Mario, not in lkml.
