Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270640AbRH1K0u>; Tue, 28 Aug 2001 06:26:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270644AbRH1K0k>; Tue, 28 Aug 2001 06:26:40 -0400
Received: from smtpde02.sap-ag.de ([194.39.131.53]:47028 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S270640AbRH1K02>; Tue, 28 Aug 2001 06:26:28 -0400
From: Christoph Rohland <cr@sap.com>
To: Jens Axboe <axboe@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@redhat.com>
Subject: Re: [patch] zero-bounce block highmem I/O, #13
In-Reply-To: <20010827123700.B1092@suse.de>
Organisation: SAP LinuxLab
Date: 28 Aug 2001 12:26:08 +0200
In-Reply-To: <20010827123700.B1092@suse.de>
Message-ID: <m3itf85vlr.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SAP: out
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,

I tested both #11 and #13 on my 8GB machine with sym53c8xx. The
initialization of a SAP DB database takes 20 minutes with 2.4.9 and
with 2.4.9+b13 it took nearly 2.5 hours :-(

Greetings
		Christoph


