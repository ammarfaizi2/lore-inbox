Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262754AbVF3AA2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262754AbVF3AA2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 20:00:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262762AbVF3AA2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 20:00:28 -0400
Received: from mx13.sac.fedex.com ([199.81.197.53]:52740 "EHLO
	mx13.sac.fedex.com") by vger.kernel.org with ESMTP id S262747AbVF2X5W
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 19:57:22 -0400
Date: Thu, 30 Jun 2005 07:59:21 +0800 (SGT)
From: Jeff Chua <jeffchua@silk.corp.fedex.com>
X-X-Sender: root@boston.corp.fedex.com
To: Rusty Lynch <rusty@linux.intel.com>
cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
       Jeff Chua <jeffchua@silk.corp.fedex.com>,
       Alejandro Bonilla <abonilla@linuxwireless.org>,
       "'Arjan van de Ven'" <arjan@infradead.org>,
       "'Jeff Chua'" <jeff96@silk.corp.fedex.com>,
       ipw2100-devel@lists.sourceforge.net,
       "'Linux Kernel'" <linux-kernel@vger.kernel.org>
Subject: Re: [Ipw2100-devel] Re: ipw2200 can't compile under linux 2.6.13-rc1
In-Reply-To: <20050629223540.GA22949@linux.jf.intel.com>
Message-ID: <Pine.LNX.4.63.0506300758240.17371@boston.corp.fedex.com>
References: <jeffchua@silk.corp.fedex.com> <Pine.LNX.4.63.0506292209050.6581@boston.corp.fedex.com>
 <200506291655.j5TGtpkX011008@laptop11.inf.utfsm.cl> <20050629223540.GA22949@linux.jf.intel.com>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 06/30/2005
 07:57:05 AM,
	Serialize by Router on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 06/30/2005
 07:57:08 AM,
	Serialize complete at 06/30/2005 07:57:08 AM
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Jun 2005, Rusty Lynch wrote:

> The prototype for the driver show and store functions has a new argument,
> struct device_attribute *.  Here is a patch that adds the argument for the
> many device files that the ipw2200 has.

That works nicely. Thanks.

Jeff.
