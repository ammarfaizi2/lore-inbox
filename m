Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130878AbRBMJUK>; Tue, 13 Feb 2001 04:20:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130921AbRBMJTu>; Tue, 13 Feb 2001 04:19:50 -0500
Received: from host217-32-132-155.hg.mdip.bt.net ([217.32.132.155]:59908 "EHLO
	penguin.homenet") by vger.kernel.org with ESMTP id <S130878AbRBMJTm>;
	Tue, 13 Feb 2001 04:19:42 -0500
Date: Tue, 13 Feb 2001 09:20:14 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: linux-kernel@vger.kernel.org
Subject: lost charaters -- this is becoming annoying!
Message-ID: <Pine.LNX.4.21.0102130915490.927-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I amtyping this without correcting -- allthe lost characters you see
(including spaces!) are exactly what the pseudo-tty driver does! This is
2.4.1 a it definitely (oh, see "nd" of the ave "and" disappeared? and
"above" turned into "ave"!) did work fine previously -- like in the days
of 2.3.99 and 2.4.0-teX series (yes, teX was meant to be "testX"!)

So, the keyboard or pty driver is badly broken.

Regards,
Tigran

PS. This only happens on this Dell latitude CPx (notice lost shift in
Latitude?) H450GT. 

PPS. No, my laptop is fine -- rebootingnto 2.2.x makes it type without
loosing characters...

