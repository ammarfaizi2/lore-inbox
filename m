Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263842AbUEMGyp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263842AbUEMGyp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 02:54:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263843AbUEMGyp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 02:54:45 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:40179 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S263842AbUEMGyo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 02:54:44 -0400
Subject: Re: [Lhns-devel] Re: Node Hotplug Support
From: Dave Hansen <haveblue@us.ibm.com>
To: Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       hotplug devel <linux-hotplug-devel@lists.sourceforge.net>,
       lhns-devel@lists.sourceforge.net
In-Reply-To: <1084430738.3189.1.camel@nighthawk>
References: <20040508003904.63395ca7.tokunaga.keiich@jp.fujitsu.com>
	 <1083944945.23559.1.camel@nighthawk>
	 <20040510104725.7c9231ee.tokunaga.keiich@jp.fujitsu.com>
	 <1084167941.28602.478.camel@nighthawk>
	 <20040513102751.48c61d48.tokunaga.keiich@jp.fujitsu.com>
	 <1084413887.974.7.camel@nighthawk>
	 <20040513153505.21c5fc15.tokunaga.keiich@jp.fujitsu.com>
	 <1084430738.3189.1.camel@nighthawk>
Content-Type: text/plain
Message-Id: <1084431281.3189.9.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 12 May 2004 23:54:41 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-05-12 at 23:45, Dave Hansen wrote:
> On Wed, 2004-05-12 at 23:35, Keiichiro Tokunaga wrote:
> > By the way, what happen when you issue
> > "echo 0 > $NODEDIR/control/online"?  Can you detach it
> > from the system after echo-ing?
> 
> Well, since it doesn't exist yet... Sure :)

What we really need is something like eject(1) for system devices.  

-- Dave

