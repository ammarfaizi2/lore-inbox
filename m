Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262436AbVEMQ7R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262436AbVEMQ7R (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 12:59:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262434AbVEMQ7R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 12:59:17 -0400
Received: from mail.dvmed.net ([216.237.124.58]:50645 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S262438AbVEMQ6p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 12:58:45 -0400
Message-ID: <4284DCBF.6070208@pobox.com>
Date: Fri, 13 May 2005 12:58:39 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tejun Heo <htejun@gmail.com>
CC: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: About mod15write workaround
References: <20050513051057.GA12915@htj.dyndns.org>
In-Reply-To: <20050513051057.GA12915@htj.dyndns.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tejun Heo wrote:
>  Hello Jeff.
> 
>  Can you tell me if/when mod15write workaround will be merged?  It's
> been around for a while now and I haven't received any malfunciton
> report yet.  Do you care to merging it into libata-dev-2.6?

That's in the queue, but queue processing is very slow ATM.  Watch for 
things appearing in the new git repositories.

	Jeff



