Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261414AbUL2UFh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261414AbUL2UFh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 15:05:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261416AbUL2UFh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 15:05:37 -0500
Received: from dns.toxicfilms.tv ([150.254.37.24]:65471 "EHLO
	dns.toxicfilms.tv") by vger.kernel.org with ESMTP id S261414AbUL2UFc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 15:05:32 -0500
X-Qmail-Scanner-Mail-From: solt2@dns.toxicfilms.tv via dns
X-Qmail-Scanner-Rcpt-To: linux-kernel@vger.kernel.org
X-Qmail-Scanner: 1.23 (Clear:RC:0(213.238.103.71):. Processed in 0.067998 secs)
Message-ID: <04ef01c4ede2$ff4a7cc0$0e25fe0a@pysiak>
From: "Maciej Soltysiak" <solt2@dns.toxicfilms.tv>
To: <linux-kernel@vger.kernel.org>
References: <m3mzw262cu.fsf@rajsekar.pc> <41CD51E6.1070105@kolivas.org>
Subject: Re: Trying out SCHED_BATCH
Date: Wed, 29 Dec 2004 21:14:00 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Con wrote:
> Only the staircase scheduler currently has an implementation of
> sched_batch and you need 2 more patches on top of the staircase patch
> for it to work.
Hmm, Is it feasable to write a sched_batch policy for the current linux 
schedulers?

I mean, if there are people that want it bad, maybe it would be nice to be 
able
to use a version of sched_batch that would work without the staircase 
scheduler.
It is still experimental, right?

Regards,
Maciej

