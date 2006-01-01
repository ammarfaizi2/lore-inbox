Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932244AbWAATNI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932244AbWAATNI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jan 2006 14:13:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932245AbWAATNI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jan 2006 14:13:08 -0500
Received: from tirith.ics.muni.cz ([147.251.4.36]:57222 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S932244AbWAATNG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jan 2006 14:13:06 -0500
From: "Jiri Slaby" <xslaby@fi.muni.cz>
Date: Sun,  1 Jan 2006 20:12:23 +0100
To: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
Cc: Jiri Slaby <xslaby@fi.muni.cz>, Sami Farin <7atbggg02@sneakemail.com>,
       jesper.juhl@gmail.com, s0348365@sms.ed.ac.uk,
       Linux Kernel <linux-kernel@vger.kernel.org>, rlrevell@joe-job.com,
       arjan@infradead.org,
       Linux and Kernel Video <video4linux-list@redhat.com>
References: <200512310027.47757.s0348365@sms.ed.ac.uk>
	 <43B5D3ED.3080504@ns666.com> <200512310051.03603.s0348365@sms.ed.ac.uk>
	 <43B5D6D0.9050601@ns666.com> <43B65DEE.906@ns666.com>
	 <9a8748490512310308g1f529495ic7eab4bd3efec9e4@mail.gmail.com>
	 <43B66E3D.2010900@ns666.com>
	 <9a8748490512310349g10d004c7i856cf3e70be5974@mail.gmail.com>
	 <43B67DB6.2070201@ns666.com> <43B6A14E.1020703@ns666.com>
	 <20051231163414.GE3214@m.safari.iki.fi>
	 <20051231163414.GE3214@m.safari.iki.fi> <43B6B669.6020500@ns666.com>
	 <43B73DEB.4070604@ns666.com> <43B7D3BE.60003@ns666.com>
	 <43B7EB99.8010604@ns666.com> <43B7EB99.8010604@ns666.com>
	 <20060101183832.2BE0222AEE7@anxur.fi.muni.cz>  <43B8241C.2020305@ns666.com>
In-reply-to: <1136142119.849.15.camel@localhost>
Message-Id: <20060101191221.7E34322AEAC@anxur.fi.muni.cz>
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Envelope-From: xslaby@fi.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mauro Carvalho Chehab wrote:
>Em Dom, 2006-01-01 às 19:49 +0100, Mark v Wolher escreveu:
>> So, Mauro (or somebody from list), have you any idea, what could be
>> wrong?  
>	hmm.. have you sent the patch to the list?
Yes, it was only a (bad) try to solve the problem. The point is, that there is
some weird problem in the estimating, or something (number of loops?).

The oops and the patch are on lkml site in this thread, I would give you a
link, but lkml seems to be down for me.
[the patch helps in some way, but didn't solve the problem]

all the best,
-- 
Jiri Slaby         www.fi.muni.cz/~xslaby
\_.-^-._   jirislaby@gmail.com   _.-^-._/
B67499670407CE62ACC8 22A032CC55C339D47A7E
