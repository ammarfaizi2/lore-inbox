Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261533AbUBUEWG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 23:22:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261540AbUBUEWG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 23:22:06 -0500
Received: from fw.osdl.org ([65.172.181.6]:41648 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261533AbUBUEWC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 23:22:02 -0500
Date: Fri, 20 Feb 2004 20:22:24 -0800
From: Andrew Morton <akpm@osdl.org>
To: Phil White <cerise@littlegreenmen.armory.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.3 doesn't see my 2nd CPU
Message-Id: <20040220202224.5f4394cf.akpm@osdl.org>
In-Reply-To: <20040221031717.GB4827@littlegreenmen.armory.com>
References: <20040221031717.GB4827@littlegreenmen.armory.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Phil White <cerise@littlegreenmen.armory.com> wrote:
>
> ACPI disabled because your bios is from 99 and too old
>  You can enable it with acpi=force

Did you try acpi=force?  Look for a bios upgrade, too.
