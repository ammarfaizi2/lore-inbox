Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751313AbWBJTYC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751313AbWBJTYC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 14:24:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751312AbWBJTYC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 14:24:02 -0500
Received: from mx1.redhat.com ([66.187.233.31]:44702 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751313AbWBJTYA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 14:24:00 -0500
Date: Fri, 10 Feb 2006 11:23:40 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: Alex Davis <alex14641@yahoo.com>
Cc: zaitcev@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: Let's get rid of  ide-scsi
Message-Id: <20060210112340.4a215951.zaitcev@redhat.com>
In-Reply-To: <mailman.1139533140.4060.linux-kernel2news@redhat.com>
References: <mailman.1139533140.4060.linux-kernel2news@redhat.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.9; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Feb 2006 16:21:48 -0800 (PST), Alex Davis <alex14641@yahoo.com> wrote:

> I think we should get rid of ide-scsi.
> 
> Reasons:
> 1) It's broken.
> 2) It's unmaintained.
> 3) It's unneeded.

How are you going to drive IDE tapes without it? The ide-tape driver is
many times worse.

-- Pete
