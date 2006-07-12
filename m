Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751359AbWGLMrj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751359AbWGLMrj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 08:47:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751360AbWGLMrj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 08:47:39 -0400
Received: from blk-222-25-130.eastlink.ca ([24.222.25.130]:53821 "EHLO
	tick.funktronics.ca") by vger.kernel.org with ESMTP
	id S1751359AbWGLMri (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 08:47:38 -0400
From: James Oakley <joakley@solutioninc.com>
Organization: SolutionInc
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17 hangs during boot on ASUS M2NPV-VM motherboard
Date: Wed, 12 Jul 2006 09:47:13 -0300
User-Agent: KMail/1.9.3
References: <89E85E0168AD994693B574C80EDB9C27043F5D1C@uk-email.terastack.bluearc.com>
In-Reply-To: <89E85E0168AD994693B574C80EDB9C27043F5D1C@uk-email.terastack.bluearc.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607120947.13627.joakley@solutioninc.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 12 July 2006 4:58 am, Andy Chittenden wrote:
> I tried to install the linux-image-2.6.17-1-amd64-k8-smp debian package
> on a ASUS M2NPV-VM motherboard based system and it hung during boot. The
> last message on the console was:
>
> io scheduler cfq registered
>
> Anyone got any suggestions? Unfortunately, this is a production server
> so I'm going to get very little time on it to try things out. For the
> moment, I've reverted to 2.6.16 where it seems basically stable (there
> are occasional hangs with the hard disk light hard on which is why I
> tried out 2.6.17).

I just installed SUSE 10.1 on that very motherboard. It seems to work fine. I 
can even run windows under Xen using the SVM on the processor.

The kernel I'm currently running is 2.6.16.21.

-- 
James Oakley
Engineering - SolutionInc Ltd.
joakley@solutioninc.com
http://www.solutioninc.com
