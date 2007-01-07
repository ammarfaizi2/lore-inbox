Return-Path: <linux-kernel-owner+w=401wt.eu-S932486AbXAGLJ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932486AbXAGLJ7 (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 06:09:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932497AbXAGLJ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 06:09:59 -0500
Received: from sd291.sivit.org ([194.146.225.122]:1668 "EHLO sd291.sivit.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932486AbXAGLJ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 06:09:58 -0500
Subject: Re: sonypi not for 64bit?
From: Stelian Pop <stelian@popies.net>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Mattia Dongili <malattia@linux.it>
In-Reply-To: <Pine.LNX.4.61.0701070313510.23016@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0701070313510.23016@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=ISO-8859-15
Date: Sun, 07 Jan 2007 12:09:55 +0100
Message-Id: <1168168195.30005.3.camel@voyager.dsnet>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le dimanche 07 janvier 2007 à 03:21 +0100, Jan Engelhardt a écrit :
> Hi sonypi (ex-)maintainers ;-)
> 
> 
> drivers/char/Kconfig lists SONYPI as being !64BIT, however, there seem 
> to be sony users with x86_64 [1] around.

Indeed, I have had (private) reports about it working on x86_64 too.

>  Is it just caution (it's also 
> marked EXPERIMENTAL) or is it definitely known to break on 64bit?

Frankly I don't recall anymore. The 64 bit restriction wasn't there from
the beginning, it was added by a patch from someone 2 or 3 years ago.
git doesn't seem to have the history for that, maybe old bk does...

-- 
Stelian Pop <stelian@popies.net>

