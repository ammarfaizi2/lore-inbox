Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318283AbSGXIr7>; Wed, 24 Jul 2002 04:47:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318284AbSGXIr4>; Wed, 24 Jul 2002 04:47:56 -0400
Received: from [213.69.232.58] ([213.69.232.58]:8459 "HELO schottelius.org")
	by vger.kernel.org with SMTP id <S318283AbSGXIrz>;
	Wed, 24 Jul 2002 04:47:55 -0400
Date: Wed, 24 Jul 2002 12:39:28 +0200
From: Nico Schottelius <nicos-mutt@pcsystems.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: "Richard E. Gooch" <rgooch@atnf.csiro.au>
Subject: [BUG] 2.5.27 devfs /dev/vc failure
Message-ID: <20020724103927.GA487@schottelius.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-MSMail-Priority: Is not really needed
X-Mailer: Yam on Linux ?
X-Operating-System: Linux flapp 2.5.27
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello guys!

I was wondering why 2.5.27 all gettys are not started, but after logging
in via network a ls /dev/vc returned

   /dev/vc/0

and nothing more!   
And I am wondering why there is nothing running on /dev/vc/{1-6}!

I don't know the devfs code, so I will not fix it myself, but perhaps
Richard knows the problem and has fixed it while I am writing this.

Sincerly,

Nico Schottelius

-- 
Please send your messages pgp-signed and/or pgp-encrypted (don't encrypt mails
to mailing list!). If you don't know what pgp is visit www.gnupg.org.
(public pgp key: ftp.schottelius.org/pub/familiy/nico/pgp-key)
