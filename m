Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261688AbTEDUpo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 May 2003 16:45:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261702AbTEDUpo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 May 2003 16:45:44 -0400
Received: from rth.ninka.net ([216.101.162.244]:10183 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S261688AbTEDUpm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 May 2003 16:45:42 -0400
Subject: Re: [2.5.68] Scalability issues
From: "David S. Miller" <davem@redhat.com>
To: Felix von Leitner <felix-kernel@fefe.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030504194451.GA29196@codeblau.de>
References: <20030504173956.GA28370@codeblau.de>
	 <20030504194451.GA29196@codeblau.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1052079133.27465.14.camel@rth.ninka.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 04 May 2003 13:12:13 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-05-04 at 12:44, Felix von Leitner wrote:
> Here is the ksymoops output.  The taint came from the nvidia kernel
> module, X was not running, so the module did not do anything at the
> time.

Not true, if it got loaded it did something.

Either reproduce without the nvidia module loaded, or take
your report to nvidia.

-- 
David S. Miller <davem@redhat.com>
