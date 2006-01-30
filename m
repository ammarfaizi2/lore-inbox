Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932223AbWA3LcS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932223AbWA3LcS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 06:32:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932224AbWA3LcS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 06:32:18 -0500
Received: from smtp.osdl.org ([65.172.181.4]:33213 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932223AbWA3LcR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 06:32:17 -0500
Date: Mon, 30 Jan 2006 03:31:55 -0800
From: Andrew Morton <akpm@osdl.org>
To: Marc Koschewski <marc@osknowledge.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc1-mm4
Message-Id: <20060130033155.0fbb9ac1.akpm@osdl.org>
In-Reply-To: <20060130112334.GA5722@stiffy.osknowledge.org>
References: <20060129144533.128af741.akpm@osdl.org>
	<20060130112334.GA5722@stiffy.osknowledge.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Koschewski <marc@osknowledge.org> wrote:
>
> Does this release eat reiser3 partitions?
>

I hope not.  There were some bad reiser3 patches a couple of -mm's ago, but
they were hastily dropped.

