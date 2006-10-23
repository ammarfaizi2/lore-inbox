Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751880AbWJWK3v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751880AbWJWK3v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 06:29:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751881AbWJWK3u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 06:29:50 -0400
Received: from mta.songnetworks.no ([62.73.241.55]:28735 "EHLO
	vebeella.fastcom.no") by vger.kernel.org with ESMTP
	id S1751880AbWJWK3u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 06:29:50 -0400
Mime-Version: 1.0 (Apple Message framework v752.2)
In-Reply-To: <453960B3.6040006@gmail.com>
References: <C5C787DB-6791-462E-9907-F3A0438E6B9C@karlsbakk.net> <453960B3.6040006@gmail.com>
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <D3D931E5-0EA7-4CC4-A59D-364C65335DBA@karlsbakk.net>
Content-Transfer-Encoding: 7bit
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Subject: Re: Debugging I/O errors?
Date: Mon, 23 Oct 2006 12:29:49 +0200
To: linux-kernel@vger.kernel.org
X-Mailer: Apple Mail (2.752.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Roy Sigurd Karlsbakk wrote:
>
>> Hi all
>> Stresstesting a SATA drive+controller, I get the error below after  
>> a while. How can I find if this error is due to a controller  
>> failure, a bad driver, or a drive failure?
>
> Is there any libata/SCSI error messages in your log?
>

Nope. Just the ones from ext3. I first tried with a kernel from  
debian etch, and then switched to 2.6.18.1. Same errors on both

roy
--
Roy Sigurd Karlsbakk
roy@karlsbakk.net
-------------------------------
MICROSOFT: Acronym for "Most Intelligent Customers Realise Our  
Software Only Fools Teenagers"

