Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262028AbTFDAaj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 20:30:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262029AbTFDAai
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 20:30:38 -0400
Received: from dub.inr.ac.ru ([193.233.7.105]:11992 "HELO dub.inr.ac.ru")
	by vger.kernel.org with SMTP id S262028AbTFDAai (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 20:30:38 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200306040043.EAA24505@dub.inr.ac.ru>
Subject: Re: fix TCP roundtrip time update code
To: jmorris@intercode.com.au (James Morris)
Date: Wed, 4 Jun 2003 04:43:22 +0400 (MSD)
Cc: davidm@hpl.hp.com, gandalf@wlug.westbo.se, linux-kernel@vger.kernel.org,
       linux-ia64@linuxia64.org, netdev@oss.sgi.com, davem@redhat.com,
       akpm@digeo.com
In-Reply-To: <Mutt.LNX.4.44.0306041021450.28035-100000@excalibur.intercode.com.au> from "James Morris" at Jun 04, 2003 10:24:14 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> This might be the solution to one of the 'must-fix' bugs for the
> networking, which nobody so far was quite able to track down.

No doubts. All the symptoms are explained by this. I hope Andrew
will confirm that the problem has gone.

Alexey
