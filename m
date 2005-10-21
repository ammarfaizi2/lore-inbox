Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750981AbVJUFEM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750981AbVJUFEM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 01:04:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751006AbVJUFEM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 01:04:12 -0400
Received: from zctfs063.nortelnetworks.com ([47.164.128.120]:63991 "EHLO
	zctfs063.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S1750981AbVJUFEL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 01:04:11 -0400
Message-ID: <435876B8.9000706@nortel.com>
Date: Thu, 20 Oct 2005 23:03:52 -0600
From: "Christopher Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linuxppc-dev@ozlabs.org
Subject: status of kexec for ppc on 2.6.10, any gotchas?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Oct 2005 05:03:53.0517 (UTC) FILETIME=[D53125D0:01C5D5FC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've been asked to look at kexec for ppc on 2.6.10.  The syscall appears 
to be present, but there seem to be additional patches for 2.6.10-mm at:

http://www.xmission.com/~ebiederm/files/kexec/

Are these patches needed?

I haven't been able to find any current official documentation, although 
I found some old stuff from 2.5 and a writeup at:
 
http://www-128.ibm.com/developerworks/linux/library/l-kexec.html?ca=dgr-lnxw04RebootFast

Is there any official HOWTO on this?  Any issues I should look at in 
particular?

Thanks for any pointers,

Chris
