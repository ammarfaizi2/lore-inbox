Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290616AbSBLTfW>; Tue, 12 Feb 2002 14:35:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290503AbSBLTfM>; Tue, 12 Feb 2002 14:35:12 -0500
Received: from mta02-svc.ntlworld.com ([62.253.162.42]:46830 "EHLO
	mta02-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id <S290616AbSBLTe5>; Tue, 12 Feb 2002 14:34:57 -0500
Message-ID: <3C696FE4.83AAA1B9@ntlworld.com>
Date: Tue, 12 Feb 2002 19:41:24 +0000
From: SA <super.aorta@ntlworld.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Write-combining
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Have I missed something here?

Am I being dim?

Or is the usual "instant advice" feature switched off?


The device I am writing the driver for formally didn't support
write-combining and it took
10000 clock ticks to do a partial transfer- now it does support
write-combining and it still
takes 10000 clock ticks to transfer the data- It is performance
critical- How do I switch
write-combining on? It is worth at least a 2x speed up for me?

If it is something obvious please don't be afraid to point it out-----

Thanks SA

