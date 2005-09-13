Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964951AbVIMSLM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964951AbVIMSLM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 14:11:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964953AbVIMSLM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 14:11:12 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:13762 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964951AbVIMSLK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 14:11:10 -0400
Date: Tue, 13 Sep 2005 13:10:57 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: boutcher@cs.umn.edu, SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>, lxie@us.ibm.com,
       santil@us.ibm.com
Subject: Re: [Patch] ibmvscsi compatibility fix
Message-ID: <20050913181057.GA3156@IBM-BWN8ZTBWAO1>
References: <20050912024350.60e89eb1.akpm@osdl.org> <20050912222437.GA13124@sergelap.austin.ibm.com> <20050912161013.76ef833f.akpm@osdl.org> <20050913013840.GG5382@krispykreme> <20050913085643.GA24156@sergelap.austin.ibm.com> <20050913150902.GA22071@cs.umn.edu> <1126624684.4809.10.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1126624684.4809.10.camel@mulgrave>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting James Bottomley (James.Bottomley@SteelEye.com):
> On Tue, 2005-09-13 at 10:09 -0500, Dave C Boutcher wrote:
> > Andrew, while this stuff usually goes through James, it would
> > probably make Serge happier if you could pick it up for the next
> > mm.  
> 
> I'll put it in scsi-rc-fixes-2.6 ... that should be fast track for
> inclusion prior to 2.6.14 and it should also feed into the next -mm

Thanks.  As soon as another test is through I will test this patch
on my own machine with -mm2.

thanks,
-serge

