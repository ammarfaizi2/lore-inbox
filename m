Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261890AbTIYVFh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 17:05:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261891AbTIYVFh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 17:05:37 -0400
Received: from fw.osdl.org ([65.172.181.6]:2509 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261890AbTIYVFh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 17:05:37 -0400
Date: Thu, 25 Sep 2003 14:05:08 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390 (16/19): qeth driver.
Message-Id: <20030925140508.2a63ac9e.shemminger@osdl.org>
In-Reply-To: <20030925172155.GQ2951@mschwid3.boeblingen.de.ibm.com>
References: <20030925172155.GQ2951@mschwid3.boeblingen.de.ibm.com>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.4claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Also, the proc entry file_operations are all missing an owner field
entry.
