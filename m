Return-Path: <linux-kernel-owner+w=401wt.eu-S932783AbWLZU5M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932783AbWLZU5M (ORCPT <rfc822;w@1wt.eu>);
	Tue, 26 Dec 2006 15:57:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932782AbWLZU5L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Dec 2006 15:57:11 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:41270 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932780AbWLZU5L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Dec 2006 15:57:11 -0500
Message-ID: <45918CA4.3020601@garzik.org>
Date: Tue, 26 Dec 2006 15:57:08 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Divy Le Ray <None@chelsio.com>
CC: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       swise@opengridcomputing.com
Subject: Re: [PATCH 1/10] cxgb3 - main header files
References: <20061220124125.6286.17148.stgit@localhost.localdomain>
In-Reply-To: <20061220124125.6286.17148.stgit@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Divy Le Ray wrote:
> From: Divy Le Ray <divy@chelsio.com>
> 
> This patch implements the main header files of
> the Chelsio T3 network driver.
> 
> Signed-off-by: Divy Le Ray <divy@chelsio.com>

Once you think it's ready, email me a URL to a single patch that adds 
the driver to the latest linux-2.6.git kernel.  Include in the email a 
description of the driver and signed-off-by line, which will get 
directly included in the git changelog.

Adding new drivers is a bit special, because we want to merge it as a 
single changeset, but that would create a patch too large to review on 
the common kernel mailing lists.

	Jeff



