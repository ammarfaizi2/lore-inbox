Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751151AbWHBOyZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751151AbWHBOyZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 10:54:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751157AbWHBOyZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 10:54:25 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:46464 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1751151AbWHBOyY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 10:54:24 -0400
Subject: Re: Areca arcmsr kernel integration
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Theodore Bullock <tbullock@nortel.com>, robm@fastmail.fm,
       brong@fastmail.fm, erich@areca.com.tw, greg@kroah.com, dax@gurulabs.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060731200309.bd55c545.akpm@osdl.org>
References: <00a701c6b2b4$bb564b50$0e00cb0a@robm>
	 <25E284CCA9C9A14B89515B116139A94D0C78805F@zrtphxm0.corp.nortel.com>
	 <20060731200309.bd55c545.akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 02 Aug 2006 10:53:48 -0400
Message-Id: <1154530428.3683.0.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-07-31 at 20:03 -0700, Andrew Morton wrote:
> > Ok, so how does this go from here into the mainline kernel?
> 
> James has moved the driver into the scsi-misc tree, so I assume he has
> 2.6.19 plans for it.

Yes, that's the usual path for scsi-misc.

James


