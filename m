Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273921AbRI0Vid>; Thu, 27 Sep 2001 17:38:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273930AbRI0ViN>; Thu, 27 Sep 2001 17:38:13 -0400
Received: from fe100.worldonline.dk ([212.54.64.211]:62222 "HELO
	fe100.worldonline.dk") by vger.kernel.org with SMTP
	id <S273927AbRI0ViL>; Thu, 27 Sep 2001 17:38:11 -0400
Message-ID: <3BB21918.AD6761FC@eisenstein.dk>
Date: Wed, 26 Sep 2001 20:06:16 +0200
From: Jesper Juhl <juhl@eisenstein.dk>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
CC: Thomas Hood <jdthood@yahoo.co.uk>, linux-kernel@vger.kernel.org
Subject: Re: OOM killer
In-Reply-To: <3BB20C27.4125F9BA@eisenstein.dk> <1123696067.1001627554@[195.224.237.69]>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Bligh - linux-kernel wrote:

> shed:~# cat /proc/sys/vm/overcommit_memory
> 0
> shed:~# echo 1 >/proc/sys/vm/overcommit_memory
> shed:~# cat /proc/sys/vm/overcommit_memory
> 1
> shed:~# echo 0 >/proc/sys/vm/overcommit_memory
> shed:~# cat /proc/sys/vm/overcommit_memory
> 0

ahh, I see. Well, you live and learn ;)

I think I've got to do my research better before writing mails to lkml.



Best regards,
Jesper Juhl
juhl@eisenstein.dk



