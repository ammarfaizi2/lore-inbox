Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262177AbTJSTyd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 15:54:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262190AbTJSTyd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 15:54:33 -0400
Received: from ncircle.nullnet.fi ([62.236.96.207]:1990 "EHLO
	ncircle.nullnet.fi") by vger.kernel.org with ESMTP id S262177AbTJSTyb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 15:54:31 -0400
Message-ID: <50690.192.168.9.10.1066593270.squirrel@ncircle.nullnet.fi>
In-Reply-To: <1066592564.745.12.camel@bonnie79>
References: <1066592564.745.12.camel@bonnie79>
Date: Sun, 19 Oct 2003 22:54:30 +0300 (EEST)
Subject: Re: HighPoint 374
From: "Tomi Orava" <Tomi.Orava@ncircle.nullnet.fi>
To: christian.guggenberger@physik.uni-regensburg.de
Cc: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



>>There really must be some explanation why some of us are
>>having really huge problems with HPT374-contollers while for
>>others it's working just fine. I haven't exactly heard anyone
>>been too succesfull for example with Epox 8K9A3+ motherboard
>>even on this mailing-list based on previous questions seen here.
>
> well, it's not an Epox 8k9a3+ here, but an 8k5a3+ with two HPT374 onboard
> and it is working well with recent 2.6.0-test* kernels.
> I also just use JBOD - only one disk connected as /dev/hde to the first
> HPT 374,
> an IBM-DTLA-305040, and I really don't see any probs here.

Ok, this is good to know. Have you ever tried 2.4 based kernels with
that motherboard ? Also, have you ever tried running multiple
drives with that controller ? Somehow I still have this feeling
that with only one disk connected to a HPT374-controller it might
work without problems, while with multiple disks it becomes
unstable (this is the case with a a friends Epox 4PCA3+
based machine in addition to my two machines).

Can you perhaps send me off-the-list your .config and output of
/proc/interrupts so that I could compare those to mine ?

Regards,
Tomi Orava


