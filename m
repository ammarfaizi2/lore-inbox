Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266025AbRF1Q1k>; Thu, 28 Jun 2001 12:27:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266023AbRF1Q1a>; Thu, 28 Jun 2001 12:27:30 -0400
Received: from t2.redhat.com ([199.183.24.243]:3826 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S266026AbRF1Q1V>; Thu, 28 Jun 2001 12:27:21 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <Pine.LNX.4.33.0106280921460.10308-100000@localhost.localdomain> 
In-Reply-To: <Pine.LNX.4.33.0106280921460.10308-100000@localhost.localdomain> 
To: chuckw@altaserv.net
Cc: Vipin Malik <vipin.malik@daniel.com>, Aaron Lehmann <aaronl@vitelus.com>,
        Linus Torvalds <torvalds@transmeta.com>, alan@lxorguk.ukuu.org.uk,
        jffs-dev@axis.com, linux-kernel@vger.kernel.org
Subject: Re: Cosmetic JFFS patch. 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 28 Jun 2001 17:25:33 +0100
Message-ID: <31074.993745533@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


chuckw@altaserv.net said:
>  Perhaps even a boot flag of some sort to de-activate the printing of
> the /proc/credits during the kernel boot sequence. Or would the
> community rather an opt-in scenario... 

KERN_BANNER

--
dwmw2


