Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264186AbUENBVr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264186AbUENBVr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 21:21:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264192AbUENBVq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 21:21:46 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:23251 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S264186AbUENBVj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 21:21:39 -0400
Subject: Re: Node Hotplug Support
From: Dave Hansen <haveblue@us.ibm.com>
To: Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       hotplug devel <linux-hotplug-devel@lists.sourceforge.net>,
       lhns-devel@lists.sourceforge.net
In-Reply-To: <20040514101347.7cbf99f4.tokunaga.keiich@jp.fujitsu.com>
References: <20040508003904.63395ca7.tokunaga.keiich@jp.fujitsu.com>
	 <1083944945.23559.1.camel@nighthawk>
	 <20040510104725.7c9231ee.tokunaga.keiich@jp.fujitsu.com>
	 <1084167941.28602.478.camel@nighthawk>
	 <20040513102751.48c61d48.tokunaga.keiich@jp.fujitsu.com>
	 <1084413887.974.7.camel@nighthawk>
	 <20040513153505.21c5fc15.tokunaga.keiich@jp.fujitsu.com>
	 <1084430738.3189.1.camel@nighthawk>
	 <20040514101347.7cbf99f4.tokunaga.keiich@jp.fujitsu.com>
Content-Type: text/plain
Message-Id: <1084497683.8564.70.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 13 May 2004 18:21:23 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-05-13 at 18:13, Keiichiro Tokunaga wrote:
> The same way as you described in your previous email seems
> work for a container device if we have $CONTAINERD/online.
> Anyway, I feel we need to be more specific about implementation.
> Is there already any information that I can access?

I don't think I understand.  We already have the concept of a node.  Why
do we also need a container?

-- Dave

