Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267707AbRGZP1Z>; Thu, 26 Jul 2001 11:27:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267484AbRGZP1F>; Thu, 26 Jul 2001 11:27:05 -0400
Received: from 194.38.82.urbanet.ch ([194.38.82.193]:9487 "EHLO
	internet.dapsys.com") by vger.kernel.org with ESMTP
	id <S267518AbRGZP0z> convert rfc822-to-8bit; Thu, 26 Jul 2001 11:26:55 -0400
From: Edouard Soriano <e_soriano@dapsys.com>
Date: Thu, 26 Jul 2001 15:21:35 GMT
Message-ID: <20010726.15213500@dap21.dapsys.ch>
Subject: Increase number of open files
To: linux-kernel@vger.kernel.org
X-Mailer: Mozilla/3.0 (compatible; StarOffice/5.2;Linux)
X-Priority: 3 (Normal)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hello,

Kernel used: 2.4.2-2 Redhat 7.0


>From time to time I have to close some Windows on my system to perform 
some other tasks, like printing a document.

There are no messages on the log files, but my understanding is
a maximum number of concurrent files need to be modified.

Is there some parameters in /proc to set up without the need to
reconfigure the kernel ?

Regards,

E. Soriano 
