Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278603AbRJ1Rm2>; Sun, 28 Oct 2001 12:42:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278609AbRJ1RmI>; Sun, 28 Oct 2001 12:42:08 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:31501 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S278603AbRJ1RmC>; Sun, 28 Oct 2001 12:42:02 -0500
Subject: Re: xmm2 - monitor Linux MM active/inactive lists graphically
To: torvalds@transmeta.com (Linus Torvalds)
Date: Sun, 28 Oct 2001 17:48:09 +0000 (GMT)
Cc: zlatko.calusic@iskon.hr (Zlatko Calusic), axboe@suse.de (Jens Axboe),
        marcelo@conectiva.com.br (Marcelo Tosatti), linux-mm@kvack.org,
        linux-kernel@vger.kernel.org (lkml)
In-Reply-To: <Pine.LNX.4.33.0110280931590.7323-100000@penguin.transmeta.com> from "Linus Torvalds" at Oct 28, 2001 09:34:31 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15xu2b-0008QL-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Does the -ac patches have any hpt366-specific stuff? Although I suspect
> you're right, and that it's just the driver (or controller itself) being

The IDE code matches between the two. It isnt a driver change


Alan
