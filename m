Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932454AbWAFQe5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932454AbWAFQe5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 11:34:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752473AbWAFQdG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 11:33:06 -0500
Received: from server5.web4a.de ([82.149.231.244]:62850 "EHLO server5.web4a.de")
	by vger.kernel.org with ESMTP id S1752459AbWAFQah (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 11:30:37 -0500
Date: Fri, 6 Jan 2006 17:29:38 +0100
From: Martin Bretschneider <mailing-lists-mmv@bretschneidernet.de>
To: linux-kernel@vger.kernel.org, Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: PROBLEM: PS/2 keyboard does not work with 2.6.15
In-Reply-To: <E1EuVds-0000n9-00@mars.bretschneidernet.de>
References: <E1EuVds-0000n9-00@mars.bretschneidernet.de>
X-Mailer: Sylpheed-Claws 1.9.100 (GTK+ 2.8.8; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <E1EuuTC-0000mF-00@mars.bretschneidernet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Bretschneider <mailing-lists-mmv@bretschneidernet.de> wrote:

with some debugging help of Dmitry Torokhov and Jan Engelhardt I
could *not* find the cause why the PS/2 keyboard does not work.

But other things do work:
- If I connect the keyboard with the USB, it does work with 2.6.15.
- If I use another pc with an old AMD 500, the PS/2 keyboard does
work.

So, it could be a strange problem between the motherboard chipset
(nforce4), the 2.6.15 kernel and the PS/2 connection.

I am going to test some Kernels beetween 2.6.14.2 and 2.6.15 to find
the problem in some time.

Martin
-- 
http://www.bretschneidernet.de        OpenPGP-key: 0x4EA52583
           _o)(o_                         Sallust:
         -./\\//\.-              Nam idem velle atque idem
          _\_VV_/_          nolle, ea demum firma amicitia est.
