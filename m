Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262121AbTD2SSb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 14:18:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262123AbTD2SSa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 14:18:30 -0400
Received: from mail.libertysurf.net ([213.36.80.91]:26286 "EHLO
	mail.libertysurf.net") by vger.kernel.org with ESMTP
	id S262121AbTD2SSa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 14:18:30 -0400
Message-ID: <3EAEC4BE.1040702@paulbristow.net>
Date: Tue, 29 Apr 2003 20:30:22 +0200
From: Paul Bristow <paul@paulbristow.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Gregoire Favre <greg@ulima.unil.ch>
CC: linux-kernel@vger.kernel.org
Subject: Re: no ZIP (250) with 2.4.21-rc1-ac3...
References: <20030429164913.GA10060@ulima.unil.ch>
In-Reply-To: <20030429164913.GA10060@ulima.unil.ch>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gregoire Favre wrote:

>Hello,
>
>I have first tried to boot it with the ZIP in the drive, but without
>sucess :-(
>Now, I have booted without a disk in the drive, and only got those
>errors:
>  
>
You could use the ide-floppy driver instead of the ide-scsi driver.  
This should work.

>	Grégoire
>________________________________________________________________
>  
>


-- 

Paul

Email:	paul@paulbristow.net
Web:	http://paulbristow.net
ICQ:	11965223


