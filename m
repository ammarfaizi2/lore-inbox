Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264876AbTFQScx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 14:32:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264880AbTFQScx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 14:32:53 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:36750 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264876AbTFQScw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 14:32:52 -0400
Message-ID: <3EEF620A.40608@pobox.com>
Date: Tue, 17 Jun 2003 14:46:34 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: shemminger@osdl.org, Valdis.Kletnieks@vt.edu, girouard@us.ibm.com,
       stekloff@us.ibm.com, janiceg@us.ibm.com, lkessler@us.ibm.com,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com, niv@us.ibm.com
Subject: Re: patch for common networking error messages
References: <OFCA1A4F38.D782F1D3-ON85256D48.000A5CED@us.ibm.com>	<200306170434.h5H4YZPZ003025@turing-police.cc.vt.edu>	<20030617090859.0ffa0ca8.shemminger@osdl.org> <20030617.090930.102574393.davem@redhat.com>
In-Reply-To: <20030617.090930.102574393.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
>    From: Stephen Hemminger <shemminger@osdl.org>
>    Date: Tue, 17 Jun 2003 09:08:59 -0700
> 
>    Read the hotplug thread to see how Linus
>    said, he will never add a binary event daemon interface.
> 
> Funny, rtnetlink is exactly this and it is in the tree :-)


...and it's been in the tree for quite a while too.  It's a shame people 
aren't taking advantage of it's obvious utility...

	Jeff



