Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261343AbVC2UKd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261343AbVC2UKd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 15:10:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261363AbVC2UIn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 15:08:43 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:39606 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261348AbVC2UGT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 15:06:19 -0500
Message-ID: <4249B52C.2000300@pobox.com>
Date: Tue, 29 Mar 2005 15:06:04 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       schwidefsky@de.ibm.com, netdev@oss.sgi.com
Subject: Re: [PATCH] s390: claw network device driver
References: <200503290533.j2T5XEYT028850@hera.kernel.org> <4248FBFD.5000809@pobox.com> <20050328230830.5e90396f.akpm@osdl.org> <20050329071002.GA16204@havoc.gtf.org> <20050329152057.GA27840@wohnheim.fh-wedel.de>
In-Reply-To: <20050329152057.GA27840@wohnheim.fh-wedel.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jörn Engel wrote:
> On Tue, 29 March 2005 02:10:02 -0500, Jeff Garzik wrote:
> 
>>As mentioned in the email, you want netdev, not linux-net...
> 
> 
> Just out of curiosity: why are there two mailing lists?  Especially if
> one of them is the Wrong One.

<shrug>

linux-net is mostly dead.  I get the impression it is occasionally used 
by users.

netdev (as, perhaps, the name implies) is where the network developers 
hang out.

	Jeff



