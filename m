Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261849AbTDQSBW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 14:01:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261855AbTDQSBW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 14:01:22 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:65181 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S261849AbTDQSBP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 14:01:15 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Lucas Correia Villa Real <lucasvr@gobolinux.org>
Date: Thu, 17 Apr 2003 20:12:14 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [patch] VMnet/VMware workstation 4.0
Cc: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <D79F957BFD@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 Apr 03 at 13:48, Lucas Correia Villa Real wrote:

> Is there a "correct" place at vmware.com to send these patches? I tryied 
> sending it to feature-request@vmware.com, but I got no response from them. 
> 
> Anyway, below follows the patch providing support to devfs on the vmnet driver 
> for vmware workstation 4.0. 

You can send them to me if you do not trust feature-request...

Proble with your patch is that it does not look like that it will
build on 2.2.x without complaints, but I can fix that. More important
question to me is: do people really use devfs? 

And if change will not make into next WS release, I can always distribute it
from my site.
                                                Petr Vandrovec
                                                

