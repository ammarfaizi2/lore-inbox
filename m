Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270170AbUJTVWR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270170AbUJTVWR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 17:22:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267619AbUJTVQD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 17:16:03 -0400
Received: from lana.hrz.tu-chemnitz.de ([134.109.132.3]:20677 "EHLO
	lana.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id S270547AbUJTVLY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 17:11:24 -0400
To: linux-kernel@vger.kernel.org
Subject: [2.6.9] HPT372N - oops (NULL pointer dereference)
From: Ronald Wahl <ronald.wahl@informatik.tu-chemnitz.de>
Date: Wed, 20 Oct 2004 23:11:20 +0200
Message-ID: <m23c09p01z.fsf@rohan.middle-earth.priv>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Spam-Score: 0.0 (/)
X-Spam-Report: --- Start der SpamAssassin 2.64 Textanalyse (0.0 Punkte)
	Fragen an/questions to:  Postmaster TU Chemnitz <postmaster@tu-chemnitz.de>
	--- Ende der SpamAssassin Textanalyse
X-Scan-Signature: b75b3a670525627ec81a7de66e8d9271
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I just tried upgrading from 2.6.7 to 2.6.9 and got a kernel oops during
boot. Stack trace looked very similar to the one João Luis Meloni Assirati
reported on Oct 05 2004 (Subject: hpt366 under hpt372N oops). I have a
HPT372N on my board with one disk attached.

Is there any news on this issue yet? It keeps me from using 2.6.9. :-/

thanks,
ron

PS: Keep me in Cc:, please. I'm not on the list. Thx.
