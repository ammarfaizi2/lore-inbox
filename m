Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312901AbSDOQN0>; Mon, 15 Apr 2002 12:13:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312915AbSDOQNZ>; Mon, 15 Apr 2002 12:13:25 -0400
Received: from mail.mojomofo.com ([208.248.233.19]:45326 "EHLO mojomofo.com")
	by vger.kernel.org with ESMTP id <S312901AbSDOQNY>;
	Mon, 15 Apr 2002 12:13:24 -0400
Message-ID: <02db01c1e498$7180c170$58dc703f@bnscorp.com>
From: "Aaron Tiensivu" <mojomofo@mojomofo.com>
To: "Jens Axboe" <axboe@suse.de>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <20020415125606.GR12608@suse.de>
Subject: Re: [PATCH] IDE TCQ #4
Date: Mon, 15 Apr 2002 12:13:12 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Simple question but hopefully it has a simple answer.. is there a command
you can issue or flag you can look for from the output of hdparm to tell if
your hard drive is capable of TCQ before installing the patch? I have a few
IBM drives that I'm sure have TCQ abilities but I don't trust them as far as
I can throw them (being Hungarian and cursed) but I'd like to give TCQ a
whirl on my WD 120GB drives that should work OK, if they support TCQ..

Sorry if it's already been asked.. :)



