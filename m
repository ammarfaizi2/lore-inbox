Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316968AbSFAAP3>; Fri, 31 May 2002 20:15:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316969AbSFAAP3>; Fri, 31 May 2002 20:15:29 -0400
Received: from netlx009.civ.utwente.nl ([130.89.1.91]:55758 "EHLO
	netlx009.civ.utwente.nl") by vger.kernel.org with ESMTP
	id <S316968AbSFAAP1>; Fri, 31 May 2002 20:15:27 -0400
Date: Sat, 1 Jun 2002 02:15:32 +0200
From: Arjan Opmeer <a.d.opmeer@student.utwente.nl>
To: linux-kernel@vger.kernel.org
Subject: Anybody maintaining/improving floppy driver?
Message-ID: <20020601001532.GA18671@Ado.student.utwente.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Is anybody actively maintaining the Linux floppy driver? I tried to mail
Alain Knaff a question but he does not seem to respond.

In a momentary lapse of reason I decided to improve the floppy support of
the Linux adfs driver for which I have to use Alain's zeroBased.patch to be
able to read sector 0 of a floppy.

I was wondering whether this patch (or similar functionality) will be
included in the official kernel tree. This would mean I could send my
modifications to the adfs driver to its maintainer (Russell King) for
inclusion in the official source.


Arjan
