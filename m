Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261442AbVARWAO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261442AbVARWAO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 17:00:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261444AbVARWAN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 17:00:13 -0500
Received: from web30209.mail.mud.yahoo.com ([68.142.200.92]:6034 "HELO
	web30209.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S261442AbVARWAA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 17:00:00 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=H2J2cyw8bRKxKGdRahpUUH44JNDOo+GMfQ5ayhA9VN9tS+F/aKMngoKHK/zss0wxo+AYYbWX79Q/DSMfe86MASwdPwfkQBGPLLTVNxjYhdusSk6gpSgRBuTNj+3QuoTMOkpJHuHvAWaDrAHnrnWTFeEc1nmRKteR6gmTki8bi7c=  ;
Message-ID: <20050118215956.4906.qmail@web30209.mail.mud.yahoo.com>
Date: Tue, 18 Jan 2005 13:59:56 -0800 (PST)
From: Martins Krikis <mkrikis@yahoo.com>
Subject: Re: iswraid and 2.4.x?
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <58cb370e050118125536c17538@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:

> I'm just curious.  Is there already a possibility to use
> RAID10 metadata in 2.6.x kernels?

I don't think so, but provided that dm supports RAID10
it should be quite easy to get there.

  Martins Krikis
  (not speaking for my employer)




		
__________________________________ 
Do you Yahoo!? 
Yahoo! Mail - now with 250MB free storage. Learn more.
http://info.mail.yahoo.com/mail_250
