Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272512AbTHKMjY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 08:39:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272517AbTHKMjY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 08:39:24 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:6089 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S272512AbTHKMjX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 08:39:23 -0400
Message-ID: <3F378E64.9020606@pobox.com>
Date: Mon, 11 Aug 2003 08:39:00 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Mark Watts <m.watts@eris.qinetiq.com>
CC: Justin Cormack <justin@street-vision.com>,
       Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Innovision EIO DM-8301H/R SATA cards...
References: <200308081408.16564.m.watts@eris.qinetiq.com> <3F33B3B9.7030905@pobox.com> <1060355773.28644.8.camel@lotte> <200308110851.56063.m.watts@eris.qinetiq.com>
In-Reply-To: <200308110851.56063.m.watts@eris.qinetiq.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Watts wrote:
> Dippy question - is libata a 2.6 thing or is it going to be backported to 2.4?


It's for 2.4 and 2.6 right now.  You can get libata simply by using Alan 
  Cox's -ac patches for 2.4 or 2.6, or download directly from my FTP 
directories:
ftp://ftp.kernel.org/pub/linux/kernel/people/jgarzik/patchkits/
(look in "2.4" and "2.6" sub-directories for *libata*)

	Jeff



