Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273333AbRJIHDJ>; Tue, 9 Oct 2001 03:03:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273349AbRJIHDA>; Tue, 9 Oct 2001 03:03:00 -0400
Received: from foobar.isg.de ([62.96.243.63]:57473 "HELO mail.isg.de")
	by vger.kernel.org with SMTP id <S273333AbRJIHCr>;
	Tue, 9 Oct 2001 03:02:47 -0400
Message-ID: <3BC2A130.CFEBBE2D@isg.de>
Date: Tue, 09 Oct 2001 09:03:12 +0200
From: Constantin Loizides <Constantin.Loizides@isg.de>
Organization: Innovative Software AG
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9-ac18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Tobias Ringstrom <tori@ringstrom.mine.nu>
Cc: kernel-list <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.11.p4 and dd
In-Reply-To: <Pine.LNX.4.33.0110081343280.1775-100000@boris.prodako.se>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > 2.4.3 uses a large amount of buffer, 2.4.11p4 only chache.
> 
> Block devices are handled by the page cache in 2.4.10 and up.
> 

Eh, did I miss something? Thought, that meta data are still
cached in buffer cache? Did it change from 2.4.9 to 2.4.10?
What about the ac kernels? 

Constantin
