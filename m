Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262687AbTLWUAJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 15:00:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262694AbTLWUAJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 15:00:09 -0500
Received: from colin2.muc.de ([193.149.48.15]:55817 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S262687AbTLWUAG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 15:00:06 -0500
From: Stephan Maciej <stephanm@muc.de>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] add sysfs mem device support  [2/4]
Date: Tue, 23 Dec 2003 21:00:04 +0100
User-Agent: KMail/1.5.9
Cc: linux-kernel@vger.kernel.org, linux-hotplug-devel@lists.sourceforge.net
References: <20031223002126.GA4805@kroah.com> <1072193516.3472.3.camel@fur> <20031223163904.A8589@infradead.org>
In-Reply-To: <20031223163904.A8589@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200312232100.04739.stephanm@muc.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 23 December 2003 17:39, Christoph Hellwig wrote:
> I disagree. For fully static devices like the mem devices the udev
> indirection is completely superflous.

It can be considered superfluous, but OTOH I think when creating a clean 
interface it's desirable to keep the number of exceptional items as small as 
possible, IOW zero.

Stephan
