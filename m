Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263644AbUDQFAF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 01:00:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263648AbUDQFAF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 01:00:05 -0400
Received: from A8ba4.a.pppool.de ([213.6.139.164]:43904 "EHLO susi.maya.org")
	by vger.kernel.org with ESMTP id S263644AbUDQFAB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 01:00:01 -0400
From: Andreas Hartmann <andihartmann@01019freenet.de>
X-Newsgroups: fa.linux.kernel
Subject: Re: SATA support merge in 2.4.27
Date: Sat, 17 Apr 2004 06:59:23 +0200
Organization: privat
Message-ID: <c5qdjb$2ah$1@A8ba4.a.pppool.de>
References: <fa.dv8bnkv.rjkl9b@ifi.uio.no> <fa.dvodmcu.r3ql14@ifi.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: abuse@fu.berlin.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7b) Gecko/20040404
X-Accept-Language: de, en-us, en
In-Reply-To: <fa.dvodmcu.r3ql14@ifi.uio.no>
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:
> On Fri, Apr 16, 2004 at 10:51:02AM -0300, Marcelo Tosatti wrote:
> And again, unfortunately not everyone is running v2.6 on their production
> environment, yet.

That's right! I certainly won't run it before 2.6.20 or even higher on 
desktops. For example, 2.6 vanilla is much to slow (about 9%), even on 
desktops - tested with compiling. It must be fixed.

Another example: My production servers (a cluster system) are running fine 
and rockstable since years with 2.2.x.


Regards,
Andreas Hartmann
