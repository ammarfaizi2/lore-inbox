Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267449AbUJIVp1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267449AbUJIVp1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 17:45:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267450AbUJIVp1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 17:45:27 -0400
Received: from mail.broadpark.no ([217.13.4.2]:37255 "EHLO mail.broadpark.no")
	by vger.kernel.org with ESMTP id S267449AbUJIVpR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 17:45:17 -0400
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] Linux 2.6 Real Time Kernel
References: <41677E4D.1030403@mvista.com> <yw1xk6u0hw2m.fsf@mru.ath.cx>
	<1097356829.1363.7.camel@krustophenia.net>
	<yw1xis9ja82z.fsf@mru.ath.cx>
	<1097357878.1363.15.camel@krustophenia.net>
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@mru.ath.cx>
Date: Sat, 09 Oct 2004 23:45:04 +0200
In-Reply-To: <1097357878.1363.15.camel@krustophenia.net> (Lee Revell's
 message of "Sat, 09 Oct 2004 17:37:59 -0400")
Message-ID: <yw1xekk7a7mn.fsf@mru.ath.cx>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell <rlrevell@joe-job.com> writes:

> On Sat, 2004-10-09 at 17:35, Måns Rullgård wrote:
>
>> I did notice one improvement compared to vanilla 2.6.8.1.  The sound
>> didn't skip when I switched from X to a text console.  However, my
>> keyboard no longer worked in X, but that seems to be due to some
>> recent changes to the input subsystem.
>> 
>> Did you build it with our without my patch, BTW?
>
> With.  Most of the modules did not work without your patch.

Do the Montavista folks build their kernels without modules?

-- 
Måns Rullgård
mru@mru.ath.cx
