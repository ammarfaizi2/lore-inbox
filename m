Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136595AbRECKCs>; Thu, 3 May 2001 06:02:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136605AbRECKC2>; Thu, 3 May 2001 06:02:28 -0400
Received: from t2.redhat.com ([199.183.24.243]:49136 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S136595AbRECKCZ>; Thu, 3 May 2001 06:02:25 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <3AF12B94.60083603@alsa-project.org> 
In-Reply-To: <3AF12B94.60083603@alsa-project.org>  <3AF10E80.63727970@alsa-project.org> <Pine.LNX.4.05.10105030852330.9438-100000@callisto.of.borg> <15089.979.650927.634060@pizda.ninka.net> <11718.988883128@redhat.com> 
To: Abramo Bagnara <abramo@alsa-project.org>
Cc: "David S. Miller" <davem@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: unsigned long ioremap()? 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 03 May 2001 11:02:15 +0100
Message-ID: <14097.988884135@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


abramo@alsa-project.org said:
>  You understand that in this way you change a compile time warning in
> a runtime error (conditioned to path reaching, not easy to interpret,
> etc.)

> IMO this is a far less effective debugging strategy. 

True. Perhaps we should make sure the Stanford checker can find these bugs?

--
dwmw2


