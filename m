Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267725AbUHPP2S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267725AbUHPP2S (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 11:28:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267775AbUHPP2O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 11:28:14 -0400
Received: from mx1.redhat.com ([66.187.233.31]:2538 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267721AbUHPP1z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 11:27:55 -0400
Date: Mon, 16 Aug 2004 11:26:57 -0400
From: Alan Cox <alan@redhat.com>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Alan Cox <alan@redhat.com>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: PATCH: header updates for IDE changes
Message-ID: <20040816152657.GB10279@devserv.devel.redhat.com>
References: <20040815145515.GA9993@devserv.devel.redhat.com> <200408161708.04376.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408161708.04376.bzolnier@elka.pw.edu.pl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 16, 2004 at 05:08:04PM +0200, Bartlomiej Zolnierkiewicz wrote:
> These changes belong to the patches making actual use of them...

They just don't split along those lines and compile sanely. I did the entire
thing as one operation because for a lot of it there are no middle grounds.

> BTW What is the ordering in which your patches should be applied?

Time order of message sending. I guess I should have added a PATCH n of m
to it but didn't realise in time. While I've split them up for ease of
understanding its likely a few steps along the way don't yield working
IDE because of the interdependancies.

Alan

