Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750836AbVK0EFW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750836AbVK0EFW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Nov 2005 23:05:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750837AbVK0EFW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Nov 2005 23:05:22 -0500
Received: from wproxy.gmail.com ([64.233.184.195]:21718 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750836AbVK0EFW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Nov 2005 23:05:22 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=pr3+UlzIM+0rmH8/S6hUEr4sjgk6qw2UdG/ocI00on1o3zztDbvBdmLjulwyphVqkkeuA2v6102ejKqgopmky0R34gPj7c11LH5V63QPYtGc3ROHVFMZWY5WRlHCucKrTlGS0ezxTCWXTD+OehTr8PjbbkN8RxO2WrqND6aH4EM=
Message-ID: <afd776760511262005t25dc8beam1a2f5318943ebc68@mail.gmail.com>
Date: Sat, 26 Nov 2005 22:05:21 -0600
From: Mohamed El Dawy <msdawy@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Acessing page contents given page pointer?
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
 Thanks a lot for the reply to my previous problem. Sincerely appreciated.

Now, here is another quickie. I am running inside the kernel. I have a
"page" pointer. I am trying to access the page contents. How can I do
it if the page is not really in my address space? (e.g. I got the page
pointer using the function __follow_page() ).

Thanks a lot for all the help. Sincerely appreciated.
