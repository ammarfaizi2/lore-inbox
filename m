Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261280AbVEBOiU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261280AbVEBOiU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 10:38:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261290AbVEBOiU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 10:38:20 -0400
Received: from main.gmane.org ([80.91.229.2]:43923 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261280AbVEBOiP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 10:38:15 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Jon Escombe <trial@dresco.co.uk>
Subject: Re: Suspend/Resume
Date: Mon, 2 May 2005 14:23:59 +0000 (UTC)
Message-ID: <loom.20050502T161322-252@post.gmane.org>
References: <4267B5B0.8050608@davyandbeth.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 62.253.64.24 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.7) Gecko/20050416 Fedora/1.0.3-1.3.1 Firefox/1.0.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davy Durham <pubaddr2 <at> davyandbeth.com> writes:

> 
> Hi,
>   I've been trying for the last few days to get my D810 to suspend and 
> resume in linux.
> 

I have the same problem with a 2.6.11 kernel on an IBM T43, also with the new
Sonoma chipset. 

Although a PATA HDD, it appears to be presented as a SATA device (/dev/sda in
Linux). It seems to be hanging on the first disk access following a resume, and
I'm seeing the same behaviour with both APM and ACPI.

Happy to provide any information/assistance that I can to help resolve this..

Regards,
Jon.


