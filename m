Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262543AbTEPAAD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 20:00:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264037AbTEPAAC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 20:00:02 -0400
Received: from pizda.ninka.net ([216.101.162.242]:32168 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262543AbTEPAAC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 20:00:02 -0400
Date: Thu, 15 May 2003 17:12:18 -0700 (PDT)
Message-Id: <20030515.171218.34744285.davem@redhat.com>
To: chas@locutus.cmf.nrl.navy.mil
Cc: greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] add reference counting to atm_dev 
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200305151432.h4FEW5Gi012599@locutus.cmf.nrl.navy.mil>
References: <20030515052041.GA5995@kroah.com>
	<200305151432.h4FEW5Gi012599@locutus.cmf.nrl.navy.mil>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: chas williams <chas@locutus.cmf.nrl.navy.mil>
   Date: Thu, 15 May 2003 10:32:05 -0400

   In message <20030515052041.GA5995@kroah.com>,Greg KH writes:
   >It's not really bothering me, just wondering when it will go away (I see
   >it when building one of the USB ATM drivers...)
   
   the MOD_* functions in the speedtch driver don't need to be there.  

Greg, I'll push this.
