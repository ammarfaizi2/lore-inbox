Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264906AbTFQTlW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 15:41:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264909AbTFQTlW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 15:41:22 -0400
Received: from pizda.ninka.net ([216.101.162.242]:2009 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S264906AbTFQTlW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 15:41:22 -0400
Date: Tue, 17 Jun 2003 12:50:40 -0700 (PDT)
Message-Id: <20030617.125040.58438649.davem@redhat.com>
To: janiceg@us.ibm.com
Cc: jgarzik@pobox.com, shemminger@osdl.org, Valdis.Kletnieks@vt.edu,
       girouard@us.ibm.com, stekloff@us.ibm.com, lkessler@us.ibm.com,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com, niv@us.ibm.com
Subject: Re: patch for common networking error messages
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3EEF7030.6030303@us.ibm.com>
References: <3EEF66AA.3000509@us.ibm.com>
	<3EEF6A9D.6050303@pobox.com>
	<3EEF7030.6030303@us.ibm.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Janice M Girouard <janiceg@us.ibm.com>
   Date: Tue, 17 Jun 2003 14:46:56 -0500

    I could see the buffers backing up for 10/100 cards. So that case 
   favors your point.  I'm still thinking that it's a sign someone should 
   be buying a 2nd card and ramping up their network capability.  But I can 
   see your point.

And when we have 1GHZ memory busses and 10GHz cpus tomorrow,
what does this say for 1gbit and 10gbit cards?

You want to define a machine as having too much "work" or not, yet you
only want to consider one metric to do so.  Such schemes are
fundamentally flawed.
