Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262323AbTE2QU6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 12:20:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262324AbTE2QU6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 12:20:58 -0400
Received: from ginger.cmf.nrl.navy.mil ([134.207.10.161]:41639 "EHLO
	ginger.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id S262323AbTE2QU5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 12:20:57 -0400
Message-Id: <200305291634.h4TGY8sG022532@ginger.cmf.nrl.navy.mil>
To: Christoph Hellwig <hch@infradead.org>
cc: davem@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] assorted he driver cleanup 
In-reply-to: Your message of "Thu, 29 May 2003 17:19:27 BST."
             <20030529171927.A21828@infradead.org> 
X-url: http://www.nrl.navy.mil/CCS/people/chas/index.html
X-mailer: nmh 1.0
Date: Thu, 29 May 2003 12:32:27 -0400
From: chas williams <chas@cmf.nrl.navy.mil>
X-Spam-Score: () hits=-0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030529171927.A21828@infradead.org>,Christoph Hellwig writes:
>btw, could you also remove the BUS_INT_WAR hacks?  There shouldn't
>be anz SHUB1.0 Altix systems around anymore..

we still have a few :) (but they arent in service so i guess i could
remove it).
