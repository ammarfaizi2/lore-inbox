Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271614AbRH1QAe>; Tue, 28 Aug 2001 12:00:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271796AbRH1QAX>; Tue, 28 Aug 2001 12:00:23 -0400
Received: from smtpde02.sap-ag.de ([194.39.131.53]:49537 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S271614AbRH1QAN>; Tue, 28 Aug 2001 12:00:13 -0400
From: Christoph Rohland <cr@sap.com>
To: Jens Axboe <axboe@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@redhat.com>
Subject: Re: [patch] zero-bounce block highmem I/O, #13
In-Reply-To: <20010827123700.B1092@suse.de> <m3itf85vlr.fsf@linux.local>
	<20010828125520.L642@suse.de> <20010828134141.M642@suse.de>
	<m3ae0k5qic.fsf@linux.local> <20010828144326.R642@suse.de>
Organisation: SAP LinuxLab
Date: 28 Aug 2001 17:59:52 +0200
In-Reply-To: <20010828144326.R642@suse.de>
Message-ID: <m3wv3o41l3.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SAP: out
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,

On Tue, 28 Aug 2001, Jens Axboe wrote:
> Of course it depends on the type of work load how big an improvement
> you see. How much RAM is in the machine?

8GB

> It would be interesting to see profiles of stock + highmem kernels.

I just started the whole installation with profiling enabled. I will
send you date earliest tomorrow evening.

Greetings
		Christoph


