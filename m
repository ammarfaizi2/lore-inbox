Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269324AbUJKW7r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269324AbUJKW7r (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 18:59:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269320AbUJKW7q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 18:59:46 -0400
Received: from imap.gmx.net ([213.165.64.20]:19596 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S269328AbUJKW7W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 18:59:22 -0400
X-Authenticated: #4399952
Date: Tue, 12 Oct 2004 01:14:47 +0200
From: Florian Schmidt <mista.tapas@gmx.net>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: Ingo Molnar <mingo@elte.hu>, Mark_H_Johnson@Raytheon.com,
       Andrew Morton <akpm@osdl.org>, Daniel Walker <dwalker@mvista.com>,
       "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: [patch] VP-2.6.9-rc4-mm1-T5
Message-ID: <20041012011447.3e7669f8@mango.fruits.de>
In-Reply-To: <20041012005754.1d49a074@mango.fruits.de>
References: <OF29AF5CB7.227D041F-ON86256F2A.0062D210@raytheon.com>
	<20041011215909.GA20686@elte.hu>
	<20041012005754.1d49a074@mango.fruits.de>
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Oct 2004 00:57:54 +0200
Florian Schmidt <mista.tapas@gmx.net> wrote:

> hi,
> 
> i still can't build it. Fist i reverse applied T4, then applied T5 and tried
> a make bzImage. I'll try from scratch though to make sure, cause these
> errors look identical to the T4 ones.
> 

same errors.. Both with the preemptible real time thingy and without..

flo
