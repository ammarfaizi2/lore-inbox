Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030415AbWHADDc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030415AbWHADDc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 23:03:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030416AbWHADDc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 23:03:32 -0400
Received: from smtp.osdl.org ([65.172.181.4]:35812 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030415AbWHADDb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 23:03:31 -0400
Date: Mon, 31 Jul 2006 20:03:09 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Theodore Bullock" <tbullock@nortel.com>,
       James Bottomley <James.Bottomley@steeleye.com>
Cc: robm@fastmail.fm, brong@fastmail.fm, erich@areca.com.tw, greg@kroah.com,
       dax@gurulabs.com, linux-kernel@vger.kernel.org
Subject: Re: Areca arcmsr kernel integration
Message-Id: <20060731200309.bd55c545.akpm@osdl.org>
In-Reply-To: <25E284CCA9C9A14B89515B116139A94D0C78805F@zrtphxm0.corp.nortel.com>
References: <00a701c6b2b4$bb564b50$0e00cb0a@robm>
	<25E284CCA9C9A14B89515B116139A94D0C78805F@zrtphxm0.corp.nortel.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jul 2006 17:32:07 -0400
"Theodore Bullock" <tbullock@nortel.com> wrote:

> 
> >I believe these final issues have already been fixed:
> 
> Ok, so how does this go from here into the mainline kernel?

James has moved the driver into the scsi-misc tree, so I assume he has
2.6.19 plans for it.
