Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270954AbTGPQls (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 12:41:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270955AbTGPQls
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 12:41:48 -0400
Received: from smtp.netcabo.pt ([212.113.174.9]:60589 "EHLO smtp.netcabo.pt")
	by vger.kernel.org with ESMTP id S270954AbTGPQlr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 12:41:47 -0400
Message-ID: <3F15E439.70107@netcabo.pt>
Date: Thu, 17 Jul 2003 00:48:09 +0100
From: Pedro Ribeiro <deadheart@netcabo.pt>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020605
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Problems with 2.6.0-test1 && depmod
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Jul 2003 16:51:10.0791 (UTC) FILETIME=[75BE4570:01C34BBA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've just installed 2.6.0-test1 but whenever I try to use depmod, lsmod 
or insmod I get this error:

Module                  Size  Used by    Not tainted
lsmod: QM_MODULES: Function not implemented

I first noticed this when I was trying to install the nvidia drivers. 
Needless to say that I was unable to install them. What can I do to 
solve this problem? By the way,

depmod version 2.4.16

Thanks in advance,
Pedro Ribeiro

