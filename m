Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262442AbTESMkQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 08:40:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262444AbTESMkQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 08:40:16 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:45534 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S262442AbTESMkN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 08:40:13 -0400
Date: Mon, 19 May 2003 13:53:05 +0100 (IST)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: Linux Memory Management List <linux-mm@kvack.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Finalised 2.4 VM Documentation
Message-ID: <Pine.LNX.4.53.0305191329310.24249@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've finalised all the documentation that I'm going to do for the 2.4 VM
and no further updates will be posted on the web site to this version. At
this stage it has been heavily read by a number of people and there hasn't
been a complaint or correction in a few weeks now.  I'm happy to say it is
now complete (and more importantly correct) and acts as a detailed
description of the 2.4 VM, the algorithms that it is based on and
comprehensive coverage of the code. People who are only interested in the
2.5.x VMs will still find it much easier to follow when they clearly know
how 2.4 is put together.

As always, it comes in two parts. The first part is the actual
documentation and gives a description of the whole VM. The second is a
code commentary which covers a significant percentage of the VM for
guiding through the messier parts. They are available in PDF, HTML and
plain text formats.

Main site: http://www.csn.ul.ie/~mel/projects/vm/

Understanding the Linux Virtual Memory Manager
PDF:  http://www.csn.ul.ie/~mel/projects/vm/guide/pdf/understand.pdf
HTML: http://www.csn.ul.ie/~mel/projects/vm/guide/html/understand/
Text: http://www.csn.ul.ie/~mel/projects/vm/guide/text/understand.txt

Code Commentary on the Linux Virtual Memory Manager
PDF:  http://www.csn.ul.ie/~mel/projects/vm/guide/pdf/code.pdf
HTML: http://www.csn.ul.ie/~mel/projects/vm/guide/html/code
Text: http://www.csn.ul.ie/~mel/projects/vm/guide/text/code.txt

Thanks to all the people who read through it, helped me out and sent
encouragement. It's been fun.

-- 
Mel Gorman
http://www.csn.ul.ie/~mel
