Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264097AbUG1VdT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264097AbUG1VdT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 17:33:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264640AbUG1VdT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 17:33:19 -0400
Received: from fw.osdl.org ([65.172.181.6]:47313 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264097AbUG1VdS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 17:33:18 -0400
Date: Wed, 28 Jul 2004 14:36:34 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alan Cox <alan@redhat.com>
Cc: jgarzik@redhat.com, linux-kernel@vger.kernel.org,
       Ben Greear <greearb@candelatech.com>
Subject: Re: PATCH: VLAN support for 3c59x/3c90x
Message-Id: <20040728143634.0931ee07.akpm@osdl.org>
In-Reply-To: <20040728124256.GA31246@devserv.devel.redhat.com>
References: <20040728124256.GA31246@devserv.devel.redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@redhat.com> wrote:
>
> This adds VLAN support to the 3c59x/90x series hardware.

Sigh.  This has been floating about for ever.  My reluctance stemmed
from largely-theoretical-sounding objections from Don Becker which I
didn't fully understand at the time and have now forgotten.

Ben, does the patch look complete/correct to you?
