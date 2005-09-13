Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932671AbVIMPTa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932671AbVIMPTa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 11:19:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932670AbVIMPT3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 11:19:29 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:46546 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S932671AbVIMPT2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 11:19:28 -0400
Subject: Re: [Patch] ibmvscsi compatibility fix
From: James Bottomley <James.Bottomley@SteelEye.com>
To: boutcher@cs.umn.edu
Cc: serue@us.ibm.com, SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>, lxie@us.ibm.com,
       santil@us.ibm.com
In-Reply-To: <20050913150902.GA22071@cs.umn.edu>
References: <20050912024350.60e89eb1.akpm@osdl.org>
	 <20050912222437.GA13124@sergelap.austin.ibm.com>
	 <20050912161013.76ef833f.akpm@osdl.org> <20050913013840.GG5382@krispykreme>
	 <20050913085643.GA24156@sergelap.austin.ibm.com>
	 <20050913150902.GA22071@cs.umn.edu>
Content-Type: text/plain
Date: Tue, 13 Sep 2005 10:18:04 -0500
Message-Id: <1126624684.4809.10.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-09-13 at 10:09 -0500, Dave C Boutcher wrote:
> Andrew, while this stuff usually goes through James, it would
> probably make Serge happier if you could pick it up for the next
> mm.  

I'll put it in scsi-rc-fixes-2.6 ... that should be fast track for
inclusion prior to 2.6.14 and it should also feed into the next -mm

James


