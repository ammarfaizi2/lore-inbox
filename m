Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264547AbTFWAiE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 20:38:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264635AbTFWAiE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 20:38:04 -0400
Received: from pizda.ninka.net ([216.101.162.242]:12434 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S264547AbTFWAiD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 20:38:03 -0400
Date: Sun, 22 Jun 2003 17:46:41 -0700 (PDT)
Message-Id: <20030622.174641.74727201.davem@redhat.com>
To: alan@lxorguk.ukuu.org.uk
Cc: girouard@us.ibm.com, stekloff@us.ibm.com, janiceg@us.ibm.com,
       jgarzik@pobox.com, kenistonj@us.ibm.com, lkessler@us.ibm.com,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com, niv@us.ibm.com
Subject: Re: patch for common networking error messages
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1056199013.25974.27.camel@dhcp22.swansea.linux.org.uk>
References: <OFC2446DB8.6D4DA3ED-ON85256D47.007C79EE@us.ibm.com>
	<20030616.155533.63022973.davem@redhat.com>
	<1056199013.25974.27.camel@dhcp22.swansea.linux.org.uk>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Alan Cox <alan@lxorguk.ukuu.org.uk>
   Date: 21 Jun 2003 13:36:54 +0100
   
   Standardising strings is a real help for end users,

I agree.  But my objections are in the context of doing this
inside the kernel, where such things do not belong.
