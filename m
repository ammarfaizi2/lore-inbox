Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261932AbUD1T5Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261932AbUD1T5Z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 15:57:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261982AbUD1T47
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 15:56:59 -0400
Received: from [66.62.77.7] ([66.62.77.7]:63196 "EHLO mail.gurulabs.com")
	by vger.kernel.org with ESMTP id S265019AbUD1Rom (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 13:44:42 -0400
Subject: Re: 2.6.5, IPSec, NAT funnies
From: Dax Kelson <dax@gurulabs.com>
To: Aidas Kasparas <a.kasparas@gmc.lt>
Cc: linux-net@vger.kernel.org, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <408F5555.3080303@gmc.lt>
References: <1083133394.2817.40.camel@mentor.gurulabs.com>
	 <408F5555.3080303@gmc.lt>
Content-Type: text/plain
Message-Id: <1083174347.2803.9.camel@mentor.gurulabs.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-1) 
Date: Wed, 28 Apr 2004 11:45:47 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-04-28 at 00:55, Aidas Kasparas wrote:
> Kernel bug. IPSec changes ip headers, but fails to say about this to 
> conntrack. More information 
> http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=215980
> Patch at 
> http://bugs.debian.org/cgi-bin/bugreport.cgi/ipsec_conntrack.diff?bug=215980&msg=3&att=1

A 7 month old kernel bug with a patch. Is there any reason why this
hasn't been rolled into the Linus tree yet? Is the something
objectionable with the patch?

Dax Kelson
Guru Labs

