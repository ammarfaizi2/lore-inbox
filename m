Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265206AbTF1Nqo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jun 2003 09:46:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265209AbTF1Nqo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jun 2003 09:46:44 -0400
Received: from routeree.utt.ro ([193.226.8.102]:42662 "EHLO klesk.etc.utt.ro")
	by vger.kernel.org with ESMTP id S265206AbTF1Nqn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jun 2003 09:46:43 -0400
Message-ID: <39714.194.138.39.55.1056809147.squirrel@webmail.etc.utt.ro>
Date: Sat, 28 Jun 2003 17:05:47 +0300 (EEST)
Subject: Re: 2.5.73-mjb2
From: "Szonyi Calin" <sony@etc.utt.ro>
To: <mbligh@aracnet.com>
In-Reply-To: <36540000.1056736708@[10.10.2.4]>
References: <36540000.1056736708@[10.10.2.4]>
X-Priority: 3
Importance: Normal
Cc: <linux-kernel@vger.kernel.org>
X-Mailer: SquirrelMail (version 1.2.8)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MailScanner: Not scanned: please contact your Internet E-Mail Service Provider for details
X-MailScanner-Information: Please contact the ISP for more information
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Martin J. Bligh said:
> The patchset contains mainly scalability and NUMA stuff, and anything
> else that stops things from irritating me. It's meant to be pretty
> stable,  not so much a testing ground for new stuff.
>
> I'd be very interested in feedback from anyone willing to test on any
> platform, however large or small.
>
> ftp://ftp.kernel.org/pub/linux/kernel/people/mbligh/2.5.73/patch-2.5.73-mjb2.bz2
>

Are you interested in behaviour of this kernel on uniprocessor machines ?

I tested 2.5.72-mjb2 but it was full of oopses and crashes on my Duron
so I thought this patch is only for NUMA stuff.

Bye
Calin

-- 
# fortune
fortune: write error on /dev/null --- please empty the bit bucket


-----------------------------------------
This email was sent using SquirrelMail.
   "Webmail for nuts!"
http://squirrelmail.org/


