Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315060AbSD2Kts>; Mon, 29 Apr 2002 06:49:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315070AbSD2Ktr>; Mon, 29 Apr 2002 06:49:47 -0400
Received: from gollum.axion.bt.co.uk ([132.146.17.41]:24552 "EHLO
	gollum.axion.bt.co.uk") by vger.kernel.org with ESMTP
	id <S315060AbSD2Ktq>; Mon, 29 Apr 2002 06:49:46 -0400
Message-ID: <F66469FCE9C5D311B8FF0000F8FE9E070965D2AC@mbtlipnt03.btlabs.bt.co.uk>
From: chris.2.dobbs@bt.com
To: linux-kernel@vger.kernel.org
Subject: 2.5.7 pre-emptive support
Date: Mon, 29 Apr 2002 11:48:26 +0100
X-Mailer: Internet Mail Service (5.5.2654.89)
MIME-version: 1.0
Content-type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
I am getting unresolved symbols(mainly 'preemp_schedule' ) in most modules
when i compile 2.5.7 with pre-emptive support. Am i missing some base driver
or another patch or something for this option????.
Regards -CRD
