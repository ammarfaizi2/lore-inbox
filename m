Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263973AbTDWKbW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 06:31:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263987AbTDWKbW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 06:31:22 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:55942 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S263973AbTDWKbV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 06:31:21 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: rwhron@earthlink.net
Date: Wed, 23 Apr 2003 12:43:04 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: 2.5.68 state of matroxfb
Cc: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <16027A76AE0@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 22 Apr 03 at 20:24, rwhron@earthlink.net wrote:
> 
> Perhaps it's easier for Petr to maintain matroxfb outside Linus' tree
> at the moment.  I'm glad he keeps putting his patches up.  

I'll try to put stripped down matroxfb into kernel sometime in future...
Unfortunately as 2.5.x fbdev infrastructure does not fullfill my needs,
it will be stripped down version (which fits into current fbdev, and
which will not support text mode & fbset -fb /dev/tty*), and I'll not 
test it a lot, as it is hard to test something you cannot use in daily 
work...
                                            Best regards,
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz
                                                

