Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261752AbUEKU7W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261752AbUEKU7W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 16:59:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263646AbUEKU7W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 16:59:22 -0400
Received: from smtpq1.home.nl ([213.51.128.196]:34947 "EHLO smtpq1.home.nl")
	by vger.kernel.org with ESMTP id S261752AbUEKU7V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 16:59:21 -0400
Message-ID: <40A13E48.5050803@keyaccess.nl>
Date: Tue, 11 May 2004 22:57:44 +0200
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040117
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dmitry Ivanov <dimss@solutions.lv>
CC: Gerardo Exequiel Pozzi <vmlinuz386@yahoo.com.ar>,
       linux-kernel@vger.kernel.org, B.Zolnierkiewicz@elka.pw.edu.pl,
       mikeserv@bmts.com
Subject: Re: linux-2.6.6: ide-disks are shutdown on reboot
References: <20040511142017.1bc39ce1.vmlinuz386@yahoo.com.ar> <40A133BF.90403@keyaccess.nl> <20040511203628.GA30754@new.solutions.lv>
In-Reply-To: <20040511203628.GA30754@new.solutions.lv>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Ivanov wrote:

> drivers/ide/ide-disk.c:1707: error: `SYSTEM_RESTART' undeclared
> (first use in this function)
> 
> I cannot find definition of SYSTEM_RESTART with grep too.

As said, you need this one first:

http://marc.theaimsgroup.com/?l=linux-kernel&m=108425291909843&w=2

Rene.


