Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261347AbREPXen>; Wed, 16 May 2001 19:34:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262142AbREPXec>; Wed, 16 May 2001 19:34:32 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:26125 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262141AbREPXeS>; Wed, 16 May 2001 19:34:18 -0400
Subject: Re: PATCH: wd7000 missing release_region
To: Marcus.Meissner@caldera.de (Marcus Meissner)
Date: Thu, 17 May 2001 00:31:19 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <20010516123532.A1567@caldera.de> from "Marcus Meissner" at May 16, 2001 12:35:32 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E150AlD-0004cY-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> One else case in wd7000.c did not have a release_region().

Most of these are fixed in -ac and have been for a while. Im not sure if this
one is but do double check the -ac patches for these. I've yet to have 
Linus bandwidth to feed them all on
