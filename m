Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271042AbTHQVIQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 17:08:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271043AbTHQVIQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 17:08:16 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:12493 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S271042AbTHQVIO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 17:08:14 -0400
Message-ID: <3F3FEEAF.2070608@pobox.com>
Date: Sun, 17 Aug 2003 17:07:59 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: rob@landley.net
CC: linux-kernel@vger.kernel.org
Subject: Re: make htmldocs is broken.
References: <200308170618.35939.rob@landley.net>
In-Reply-To: <200308170618.35939.rob@landley.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Landley wrote:
> Standard Red Hat 9 install (with 2.6.0-test3-bk1), did a make htmldocs, and it 
> barfed like so:
> 
> 
>> DOCPROC Documentation/DocBook/parportbook.sgml
>> FIG2PNG Documentation/DocBook/parport-share.png
>>/bin/sh: line 1: fig2dev: command not found
>>make[1]: *** [Documentation/DocBook/parport-share.png] Error 127
> 
> 
> Does this command live on default installs of SuSE or debian or something?  
> (Or maybe it was in RH 7 or so and has been removed?)


Red Hat and Debian ship this program in their current distros, in the 
transfig package.

	Jeff



