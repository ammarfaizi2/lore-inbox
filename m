Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265112AbTLFLkk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 06:40:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265119AbTLFLkk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 06:40:40 -0500
Received: from pa208.myslowice.sdi.tpnet.pl ([213.76.228.208]:748 "EHLO
	finwe.eu.org") by vger.kernel.org with ESMTP id S265112AbTLFLkd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 06:40:33 -0500
Date: Sat, 6 Dec 2003 12:40:42 +0100
From: Jacek Kawa <jfk@zeus.polsl.gliwice.pl>
To: Jens Benecke <jens-usenet@spamfreemail.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Help: 2.4 -> 2.6 (test11,bk2) kernel module file size (due to debug options?)
Message-ID: <20031206114042.GA13349@finwe.eu.org>
Mail-Followup-To: Jens Benecke <jens-usenet@spamfreemail.de>,
	linux-kernel@vger.kernel.org
References: <bqs6rq$vv3$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bqs6rq$vv3$1@sea.gmane.org>
Organization: Kreatorzy Kreacji Bialej
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Benecke wrote:

> after installing (actually - creating a debian package for) 2.6.0-test11-bk2
> I have this:
> 2.3M    /boot
> 366M    /lib/modules/2.6.0-test11-bk2                           !!!
> 15k     /usr/share/doc/kernel-image-2.6.0-test11-bk2
> 
> Almost all .ko files are >200k in size. What kernel setting is/can be
> responsible for this?

IIRC CONFIG_DEBUG_INFO

[...]
> .config attached. 

Not here...

bye

-- 
Jacek Kawa  **Trust practically no-one... Except trustworthy people.** ['Jingo']
