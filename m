Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264205AbUEMN6o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264205AbUEMN6o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 09:58:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264206AbUEMN6o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 09:58:44 -0400
Received: from ns.suse.de ([195.135.220.2]:62155 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264205AbUEMN6n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 09:58:43 -0400
Date: Thu, 13 May 2004 15:58:41 +0200
From: Andi Kleen <ak@suse.de>
To: Dave Jones <davej@redhat.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: i810 AGP fails to initialise (was Re: 2.6.6-mm2)
Message-Id: <20040513155841.6022e7b0.ak@suse.de>
In-Reply-To: <20040513135308.GA2622@redhat.com>
References: <20040513032736.40651f8e.akpm@osdl.org>
	<6usme4v66s.fsf@zork.zork.net>
	<20040513135308.GA2622@redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 May 2004 14:53:08 +0100
Dave Jones <davej@redhat.com> wrote:

> 
> Damn, probably something trivially wrong in Andi's changes.
> 
> Andi?

lspci and lspci -n of the failing system please.

-Andi
