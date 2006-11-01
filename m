Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946760AbWKALMI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946760AbWKALMI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 06:12:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946773AbWKALMI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 06:12:08 -0500
Received: from main.gmane.org ([80.91.229.2]:39118 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1946760AbWKALMG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 06:12:06 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Rolf Offermanns <roffermanns@gmail.com>
Subject: Re: mmaping a kernel buffer to user space
Date: Wed, 1 Nov 2006 11:11:46 +0000 (UTC)
Message-ID: <loom.20061101T120846-320@post.gmane.org>
References: <4547150F.8070408@ti.uni-mannheim.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 84.58.168.87 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1) Gecko/20061010 Firefox/2.0)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guillermo Marcus <marcus <at> ti.uni-mannheim.de> writes:
> Note: I am using kernel 2.6.9 for these tests, as it is required by my
> current setup. Maybe this issue has already been addressed in newer
> kernel. If that is the case, please let me know.

Have a look at this article:

"The evolution of driver page remapping"
http://lwn.net/Articles/162860/

It should make things clearer. 

The "API changes in the 2.6 kernel series" page is also a very good read:
http://lwn.net/Articles/2.6-kernel-api/

HTH,
Rolf

