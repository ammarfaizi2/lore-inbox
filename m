Return-Path: <linux-kernel-owner+w=401wt.eu-S932393AbXARPIW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932393AbXARPIW (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 10:08:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752058AbXARPIW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 10:08:22 -0500
Received: from mail.parknet.jp ([210.171.160.80]:2044 "EHLO parknet.jp"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752057AbXARPIV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 10:08:21 -0500
X-AuthUser: hirofumi@parknet.jp
To: condor@stz-bg.com
Cc: "Kasper Sandberg" <lkml@metanurb.dk>, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: writting files > 100 MB in FAT32
References: <48247.82.103.71.18.1169112129.squirrel@mail.stz-bg.com>
	<1169123236.12968.6.camel@localhost>
	<31333.83.228.43.37.1169131305.squirrel@mail.stz-bg.com>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Fri, 19 Jan 2007 00:08:11 +0900
In-Reply-To: <31333.83.228.43.37.1169131305.squirrel@mail.stz-bg.com> (condor@stz-bg.com's message of "Thu\, 18 Jan 2007 16\:41\:45 +0200 \(EET\)")
Message-ID: <87bqkwv0dg.fsf@duaron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Condor" <condor@stz-bg.com> writes:

> I no longer can make tests because i remove my fat32 from my usb stick and
> i put it in to FAT16 and i make the exact tests and file is worked but on
> fat16 not in fat32. I just report the problem, to be investigate from
> kernel developers.

Could you send the log of kernel? I'd like to see what the fat driver said.
And if you still have the log of dosfsck, please it too.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
