Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277253AbRJDWS5>; Thu, 4 Oct 2001 18:18:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277255AbRJDWSr>; Thu, 4 Oct 2001 18:18:47 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:55568 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S277253AbRJDWSl>; Thu, 4 Oct 2001 18:18:41 -0400
Subject: Re: [POT] Which journalised filesystem ?
To: davej@suse.de (Dave Jones)
Date: Thu, 4 Oct 2001 23:24:27 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org (lk)
In-Reply-To: <Pine.LNX.4.30.0110050012430.3618-100000@Appserv.suse.de> from "Dave Jones" at Oct 05, 2001 12:14:43 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15pGup-0004U9-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So the case I mentioned to you about 2 months ago was some 'quirk'
> of the drive rather than its write cache ? (Yup, 20gb IBM).
> I'm sure you mentioned write cache in relation to that, but I could
> be wrong.

Write cache yes - not apparently writing it out always on suspend/power off
