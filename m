Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262389AbRE0QJ7>; Sun, 27 May 2001 12:09:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262796AbRE0QJt>; Sun, 27 May 2001 12:09:49 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:41995 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262389AbRE0QJb>; Sun, 27 May 2001 12:09:31 -0400
Subject: Re: [PATCH] zr36120.c
To: suntzu@stanford.edu (John Martin)
Date: Sun, 27 May 2001 13:36:07 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
In-Reply-To: <Pine.GSO.4.31.0105261911170.2445-100000@epic17.Stanford.EDU> from "John Martin" at May 26, 2001 07:25:52 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E153zmB-0001o5-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I found this error using xgcc with metal as an error checker.  It seems to
> be a simple case of not freeing allocatd memory on an error path.
>     -john martin

Already fixed in -ac

