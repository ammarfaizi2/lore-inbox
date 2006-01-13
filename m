Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161604AbWAMBC6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161604AbWAMBC6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 20:02:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161618AbWAMBC6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 20:02:58 -0500
Received: from smtp.osdl.org ([65.172.181.4]:5081 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161604AbWAMBC5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 20:02:57 -0500
Date: Thu, 12 Jan 2006 17:04:51 -0800
From: Andrew Morton <akpm@osdl.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: cornelia.huck@de.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [patch 13/13] s390: email-address change.
Message-Id: <20060112170451.48438cb2.akpm@osdl.org>
In-Reply-To: <20060112171932.GN16629@skybase.boeblingen.de.ibm.com>
References: <20060112171932.GN16629@skybase.boeblingen.de.ibm.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Schwidefsky <schwidefsky@de.ibm.com> wrote:
>
> [patch 13/13] s390: email-address change.

We can avoid churn like this by simply removing email addresses from the
code.  You can still leave the person's name there, and people can use
MAINTAINERS for the realname->email lookup.
