Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316786AbSE3P4a>; Thu, 30 May 2002 11:56:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316788AbSE3P43>; Thu, 30 May 2002 11:56:29 -0400
Received: from hera.cwi.nl ([192.16.191.8]:649 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S316786AbSE3P43>;
	Thu, 30 May 2002 11:56:29 -0400
From: Andries.Brouwer@cwi.nl
Date: Thu, 30 May 2002 17:56:26 +0200 (MEST)
Message-Id: <UTC200205301556.g4UFuQB21871.aeb@smtp.cwi.nl>
To: alan@lxorguk.ukuu.org.uk, dalecki@evision-ventures.com
Subject: Re: [PATCH] 2.5.18 IDE 73
Cc: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> LAST WARNING:

> Every body out there: watch out to use LABEL= in /etc/fstab or you will
> not be able to reboot between 2.4 and 2.5 soon!

Funny. I hope you realize that there are lots of filesystems out there
that do not support a LABEL=.

Andries
