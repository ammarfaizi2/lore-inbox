Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280029AbRKDQz0>; Sun, 4 Nov 2001 11:55:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280031AbRKDQzR>; Sun, 4 Nov 2001 11:55:17 -0500
Received: from mail309.mail.bellsouth.net ([205.152.58.169]:39232 "EHLO
	imf09bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S280029AbRKDQzK>; Sun, 4 Nov 2001 11:55:10 -0500
Message-ID: <3BE572DC.4BD4958E@mandrakesoft.com>
Date: Sun, 04 Nov 2001 11:54:52 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.13-2mdksmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rui Sousa <rui.p.m.sousa@clix.pt>
CC: "Morgan Collins [Ax0n]" <sirmorcant@morcant.org>, kwijibo@zianet.com,
        bcrl@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: emu10k emits buzzing and crackling
In-Reply-To: <Pine.LNX.4.33.0111041743030.3150-100000@sophia-sousar2.nice.mindspeed.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rui Sousa wrote:
> With the emu10k1 there is no need to use esd...

emu10k1 provides in-kernel support for multiple userspace apps sharing a
single /dev/dsp0 connection?  :)

GNOME pretty much requires esd, like KDE requires arts.

-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

