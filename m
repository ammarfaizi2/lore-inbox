Return-Path: <linux-kernel-owner+w=401wt.eu-S964978AbXAJR1K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964978AbXAJR1K (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 12:27:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964983AbXAJR1K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 12:27:10 -0500
Received: from neopsis.com ([213.239.204.14]:33310 "EHLO
	matterhorn.dbservice.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S964978AbXAJR1J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 12:27:09 -0500
Message-ID: <45A5264D.9040201@dbservice.com>
Date: Wed, 10 Jan 2007 18:45:49 +0100
From: Tomas Carnecky <tom@dbservice.com>
User-Agent: Thunderbird 2.0b1 (X11/20061212)
MIME-Version: 1.0
To: Gert Vervoort <gert.vervoort@hccnet.nl>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: oprofile broken on 2.6.19
References: <45A3FF3E.7060109@hccnet.nl>
In-Reply-To: <45A3FF3E.7060109@hccnet.nl>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Neopsis-MailScanner-Information: Neopsis MailScanner using ClamAV and Spaassassin
X-Neopsis-MailScanner: Found to be clean
X-Neopsis-MailScanner-SpamCheck: not spam, SpamAssassin (score=-2.364,
	required 5, autolearn=spam, AWL 0.23, BAYES_00 -2.60)
X-MailScanner-From: tom@dbservice.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gert Vervoort wrote:
> 
> When I try to use oprofile on 2.6.19, it does not seem to work:
> 
> [gert@apollo tmp]$ sudo opcontrol --no-vmlinux
> [gert@apollo tmp]$  sudo opcontrol --start
> /usr/bin/opcontrol: line 911: /dev/oprofile/0/enabled: No such file or
> directory/usr/bin/opcontrol: line 911: /dev/oprofile/0/event: No such
> file or directory

oh.. and next time please first try google ;)
http://www.google.ch/search?q=%2Fdev%2Foprofile%2F0%2Fevent

tom
