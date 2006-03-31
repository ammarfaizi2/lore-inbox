Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751317AbWCaLBn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751317AbWCaLBn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 06:01:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751318AbWCaLBn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 06:01:43 -0500
Received: from morbo.e-centre.net ([66.154.82.3]:42750 "EHLO
	cubert.e-centre.net") by vger.kernel.org with ESMTP
	id S1751317AbWCaLBm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 06:01:42 -0500
X-ASG-Debug-ID: 1143802885-21421-118-0
X-Barracuda-URL: http://10.3.1.19:8000/cgi-bin/mark.cgi
X-ASG-Orig-Subj: Re: [PATCH] splice exports
Subject: Re: [PATCH] splice exports
From: Arjan van de Ven <arjan@infradead.org>
To: Jeff Garzik <jeff@garzik.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       axboe@suse.de, linux-kernel@vger.kernel.org
In-Reply-To: <20060331040613.GA23511@havoc.gtf.org>
References: <20060331040613.GA23511@havoc.gtf.org>
Content-Type: text/plain
Date: Fri, 31 Mar 2006 13:01:19 +0200
Message-Id: <1143802879.3053.3.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=4.0 tests=
X-Barracuda-Spam-Report: Code version 3.02, rules version 3.0.10304
	Rule breakdown below pts rule name              description
	---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-30 at 23:06 -0500, Jeff Garzik wrote:
> Woe be unto he who builds their filesystems as modules.


since splice support is highly linux specific and new.. shouldn't these
be _GPL exports?


