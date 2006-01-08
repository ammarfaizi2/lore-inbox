Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161122AbWAHWEx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161122AbWAHWEx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 17:04:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161192AbWAHWEx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 17:04:53 -0500
Received: from server5.web4a.de ([82.149.231.244]:32988 "EHLO server5.web4a.de")
	by vger.kernel.org with ESMTP id S1161122AbWAHWEw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 17:04:52 -0500
Date: Sun, 8 Jan 2006 22:23:26 +0100
From: Martin Bretschneider <mailing-lists-mmv@bretschneidernet.de>
To: linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: PROBLEM: PS/2 keyboard does not work with 2.6.15
In-Reply-To: <E1EuVds-0000n9-00@mars.bretschneidernet.de>
References: <E1EuVds-0000n9-00@mars.bretschneidernet.de>
X-Mailer: Sylpheed-Claws 1.9.100 (GTK+ 2.8.8; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Message-Id: <E1Evi0c-0002mt-00@mars.bretschneidernet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Jens Nödler who has got the same motheboard (Gigabyte GA-K8NF-9 with
nforce4 chipset) can confirm my problem. But he found out that the
keyboard connected to the ps/2 port does work with kernel 2.6.15 if
"USB keyboard support" is disabled in the BIOS.

Martin
-- 
http://www.bretschneidernet.de        OpenPGP-key: 0x4EA52583
              (*_            Jean-Luc Picard (Star Trek TNG):
  $ cd /pub/  //\      Sometimes it's possible to make no mistakes
  $ more beer V_/_  and still lose. It is not a weakness. It is life.
