Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261375AbUKNXy0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261375AbUKNXy0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 18:54:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261376AbUKNXy0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 18:54:26 -0500
Received: from krusty.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:15845 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S261341AbUKNXyW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 18:54:22 -0500
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCH] SCSI -rc1 fixes
In-Reply-To: <1100473795.23649.26.camel@mulgrave> (James Bottomley's message
	of "14 Nov 2004 17:09:49 -0600")
References: <1100467267.23710.7.camel@mulgrave> <4197E4B7.3050008@pobox.com>
	<1100473795.23649.26.camel@mulgrave>
From: Matthias Andree <ma@dt.e-technik.uni-dortmund.de>
Date: Mon, 15 Nov 2004 00:54:14 +0100
Message-ID: <m3hdnsvvfd.fsf@merlin.emma.line.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley <James.Bottomley@SteelEye.com> writes:

> On Sun, 2004-11-14 at 17:05, Jeff Garzik wrote:
>> thankyou thankyou :)
>
> I've only been away for *two* weeks .... that's not a very long time
> compared with a linux kernel -rc cycle ...

With like 2,400 change sets since v2.6.9...

Still wondering about SuSE's hwscan issue. Has someone managed to figure
if it uses some ioctl that chokes the sym2 driver or if it hacks the
hardware?

-- 
Matthias Andree
