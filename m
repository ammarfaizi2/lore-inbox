Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279067AbRKAPMT>; Thu, 1 Nov 2001 10:12:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279079AbRKAPMJ>; Thu, 1 Nov 2001 10:12:09 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:40714 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S279067AbRKAPL5>; Thu, 1 Nov 2001 10:11:57 -0500
Subject: Re: Digest message 28, subject: 2.4.14-pre6
To: mfedyk@matchmail.com (Mike Fedyk)
Date: Thu, 1 Nov 2001 15:18:12 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), jabiru_croc@yahoo.com (Brad Chapman),
        linux-kernel@vger.kernel.org
In-Reply-To: <20011101012452.A12521@mikef-linux.matchmail.com> from "Mike Fedyk" at Nov 01, 2001 01:24:52 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15zJbg-0007Zt-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> When do you plan on switching to the -aa vm?

When it works

> Is there chance that you could add the blockdev in pagecache patch first, or
> are they interdependent?

They are pretty much seperate. When Al Viro is happy he's cleaned all that
mess up I'll look into it
