Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261410AbRFNH6H>; Thu, 14 Jun 2001 03:58:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261454AbRFNH5r>; Thu, 14 Jun 2001 03:57:47 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:25097 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S261410AbRFNH5k>; Thu, 14 Jun 2001 03:57:40 -0400
Subject: Re: obsolete code must die
To: rmager@vgkk.com (Rainer Mager)
Date: Thu, 14 Jun 2001 08:56:06 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <NEBBJBCAFMMNIHGDLFKGCEFCEEAA.rmager@vgkk.com> from "Rainer Mager" at Jun 14, 2001 10:45:10 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15ARz4-0004Jm-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Would it make sense to create some sort of 'make config' script that
> determines what you want in your kernel and then downloads only those
> components? After all, with the constant release of new hardware, isn't a
> 50MB kernel release not too far away? 100MB?

This should be a FAQ entry.

For folks doing kernel development a split tree is a nightmare to manage so
we dont bother. Nothing stops a third party splitting and maintaining the tools
to download just the needed bits for those who want to do it that way

