Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262578AbVCDFBH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262578AbVCDFBH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 00:01:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262625AbVCDE7r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 23:59:47 -0500
Received: from CPE0020e06a7211-CM0011ae8cd564.cpe.net.cable.rogers.com ([69.194.86.29]:35712
	"EHLO kenichi") by vger.kernel.org with ESMTP id S261582AbVCDE1A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 23:27:00 -0500
From: Andrew James Wade 
	<ajwade@cpe0020e06a7211-cm0011ae8cd564.cpe.net.cable.rogers.com>
To: linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
Date: Thu, 3 Mar 2005 22:23:04 -0500
User-Agent: KMail/1.7.1
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org> <20050302165830.0a74b85c.davem@davemloft.net> <200503022114.20214.gene.heskett@verizon.net>
In-Reply-To: <200503022114.20214.gene.heskett@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503032223.05172.ajwade@cpe0020e06a7211-cm0011ae8cd564.cpe.net.cable.rogers.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On March 2, 2005 09:14 pm, Gene Heskett wrote:
> One doesn't have to be a code monkey to do this 'canary' scene as long 
> as a bash script can be hacked up to do the majority of the work, I 
> have a couple of them that basicly make a new kernel install a no 
> brainer.  Often under 30 minutes to being rebooted to a new rc from 
> going after the patch.

I'm a casual user, and I'm happy to bang on the latest (-mm) kernels
so long as my data doesn't get corrupted. But the process of
downloading, patching, configuring, compiling, and installing a new
kernel is a bit of a pain, requiring user intervention a number of
times. It's enough that I don't update very often.

I've just done a bit of looking for scripts to automate the process of
installing a new kernel, and I haven't come up with much of much. So
right now I'm writing my own. If there are tools to help automate this
they need to be more prominent on www.kernel.org and
www.kernelnewbies.org, to make casual testing even easier.
