Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270658AbTG1UJb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 16:09:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270672AbTG1UJb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 16:09:31 -0400
Received: from e166066.upc-e.chello.nl ([213.93.166.66]:3264 "EHLO
	hypnos.var.cx") by vger.kernel.org with ESMTP id S270658AbTG1UIW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 16:08:22 -0400
Date: Mon, 28 Jul 2003 22:08:16 +0200
From: Frank v Waveren <fvw@var.cx>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Turning off automatic screen clanking
Message-ID: <1059422724VQM.fvw@tracks.var.cx>
References: <Pine.LNX.4.53.0307281555400.27569@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0307281555400.27569@chaos>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 28, 2003 at 04:00:03PM -0400, Richard B. Johnson wrote:
> I have experimentally determined that I can turn off
> the automatic screen blanking with the following escape
> sequence.
I'm not aware of an ioctl for this, however experimental determination
is hardly necessary, see setterm (specificly the -blank bit).

-- 
Frank v Waveren                                      Fingerprint: 21A7 C7F3
fvw@[var.cx|stack.nl|chello.nl] ICQ#10074100            1FF3 47FF 545C CB53
Public key: hkp://wwwkeys.pgp.net/fvw@var.cx            7BD9 09C0 3AC1 6DF2
