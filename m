Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751848AbWJMTln@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751848AbWJMTln (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 15:41:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751849AbWJMTlm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 15:41:42 -0400
Received: from uni20mr.unity.ncsu.edu ([152.1.2.39]:27043 "EHLO
	uni20mr.unity.ncsu.edu") by vger.kernel.org with ESMTP
	id S1751848AbWJMTlm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 15:41:42 -0400
Subject: Re: [PATCH] Readability improvement of open_exec()
From: Casey Dahlin <cjdahlin@ncsu.edu>
To: Christoph Hellwig <hch@infradead.org>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20061013073010.GB13531@infradead.org>
References: <1160707333.3230.14.camel@localhost.localdomain>
	 <20061013073010.GB13531@infradead.org>
Content-Type: text/plain
Date: Fri, 13 Oct 2006 15:41:21 -0400
Message-Id: <1160768481.2885.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
X-PMX-Version: 5.2.0.264296, Antispam-Engine: 2.4.0.264935, Antispam-Data: 2006.10.13.121942
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> While you're cleaning up things you can put the whole if statement on
> one line, it's less than 80 characters long.
> 

Ah, true. It was on one two lines back when it was tabbed all the way
over. It also seems that this mail tool turned the tabs to spaces X( so
I'll probably have to submit again anyway.

