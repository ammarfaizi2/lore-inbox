Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161632AbWJaLkn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161632AbWJaLkn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 06:40:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161635AbWJaLkn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 06:40:43 -0500
Received: from mta.songnetworks.no ([62.73.241.54]:49394 "EHLO
	pebbles.fastcom.no") by vger.kernel.org with ESMTP id S1161632AbWJaLkm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 06:40:42 -0500
Mime-Version: 1.0 (Apple Message framework v752.2)
In-Reply-To: <D3D931E5-0EA7-4CC4-A59D-364C65335DBA@karlsbakk.net>
References: <C5C787DB-6791-462E-9907-F3A0438E6B9C@karlsbakk.net> <453960B3.6040006@gmail.com> <D3D931E5-0EA7-4CC4-A59D-364C65335DBA@karlsbakk.net>
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <A9AF211A-08C8-4FC4-8280-D3AA3136FF3B@karlsbakk.net>
Content-Transfer-Encoding: 7bit
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Subject: Debugging I/O errors further?
Date: Tue, 31 Oct 2006 12:40:44 +0100
To: linux-kernel@vger.kernel.org
X-Mailer: Apple Mail (2.752.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Roy Sigurd Karlsbakk wrote:
>>
>>> Hi all
>>> Stresstesting a SATA drive+controller, I get the error below  
>>> after a while. How can I find if this error is due to a  
>>> controller failure, a bad driver, or a drive failure?
>>
>> Is there any libata/SCSI error messages in your log?
>>
>
> Nope. Just the ones from ext3. I first tried with a kernel from  
> debian etch, and then switched to 2.6.18.1. Same errors on both

Hi all

Sorry for stressing this, but is there a way I can debug this  
further? it's a seagate drive connected to a sata_sil controller. I  
only get ext3 errors, and it fails after a while whatever I do

thanks

roy
--
Roy Sigurd Karlsbakk
roy@karlsbakk.net
-------------------------------
MICROSOFT: Acronym for "Most Intelligent Customers Realise Our  
Software Only Fools Teenagers"

