Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261581AbUKOMox@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261581AbUKOMox (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 07:44:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261584AbUKOMox
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 07:44:53 -0500
Received: from imap.gmx.net ([213.165.64.20]:43692 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261581AbUKOMow (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 07:44:52 -0500
From: Stephan Menzel <stephan42@chinguarime.net>
Organization: Chinguarime
To: linux-kernel@vger.kernel.org
Subject: Re: [FS] New monitor framework in 2.6.10?
Date: Mon, 15 Nov 2004 13:44:50 +0100
User-Agent: KMail/1.7.1
References: <200411151113.06386.stephan42@chinguarime.net> <Pine.LNX.4.53.0411151121240.6893@yvahk01.tjqt.qr> <200411151142.33640.stephan42@chinguarime.net>
In-Reply-To: <200411151142.33640.stephan42@chinguarime.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411151344.50668.stephan42@chinguarime.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 15. November 2004 11:42 schrieb Stephan Menzel:
> > Wasnot it called System Call Auditing and/or Filesystem hooks?
>
> Well, that's what I'd like to know.

And I just found an answer:

inotify. http://lwn.net/Articles/104312/ 
That looks fine to me.
What happened to this? It's not in the vanilla 2.6.9 as far as I can see. Will 
it be in 2.6.10?

Greetings...

Stephan
