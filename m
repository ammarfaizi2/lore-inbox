Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261809AbUCQQsa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 11:48:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261898AbUCQQsa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 11:48:30 -0500
Received: from mailgw.cvut.cz ([147.32.3.235]:52361 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S261809AbUCQQs3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 11:48:29 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Mark Watts <m.watts@eris.qinetiq.com>
Date: Wed, 17 Mar 2004 17:48:08 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: vmware on linux 2.6.4
Cc: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <F33BEF5248@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 Mar 04 at 16:19, Mark Watts wrote:
> > > Suggestions welcome.
> >
> > what vmware version do you use? Please make sure you've updated to latest
> > any-any update from (1.)
> 
> What does this update actually do?

I would suggest reading changelog from any-any update. Entries after
update50 (and second half of update50) are ones which are NOT in modules
which come with WS4.5.1. If modules coming with WS4.5.1 work for you, 
fine. If they do not work, you know where to find update...

Update does not handle GSX 3.0 yet, so if you are using GSX 3.0, you
should stick with officially supported host kernels (if you bought
GSX, you probably want to have support, and so you should use only
supported hosts anyway).
                                                        Petr Vandrovec

