Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264246AbTDJX17 (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 19:27:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264247AbTDJX17 (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 19:27:59 -0400
Received: from pizda.ninka.net ([216.101.162.242]:51147 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S264246AbTDJX16 (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Apr 2003 19:27:58 -0400
Date: Thu, 10 Apr 2003 16:33:38 -0700 (PDT)
Message-Id: <20030410.163338.113915157.davem@redhat.com>
To: akpm@digeo.com
Cc: davej@codemonkey.org.uk, cat@zip.com.au, linux-kernel@vger.kernel.org,
       sct@redhat.com, akpm@zip.com.au, adilger@clusterfs.com,
       jmorris@intercode.com.au
Subject: Re: 2.5.67: ext3 and tcp BUG()/oops/error/whatnot?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030410141443.730ead79.akpm@digeo.com>
References: <20030410163857.GB19129@zip.com.au>
	<20030410173017.GB20177@suse.de>
	<20030410141443.730ead79.akpm@digeo.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andrew Morton <akpm@digeo.com>
   Date: Thu, 10 Apr 2003 14:14:43 -0700
   
   I've had the below patch in -mm for some time, but am not sure what to do
   with it.  My last attempt to contact netfilter people didn't work.

Whatever fix eventually is used, we need a 2.4.x copy as well
as the code is identical there.
