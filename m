Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263800AbUDUAqL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263800AbUDUAqL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 20:46:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264300AbUDUAqL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 20:46:11 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:57985 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S263800AbUDUAqJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 20:46:09 -0400
Date: Tue, 20 Apr 2004 20:46:34 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.4] fix module load with gcc3.3.3
In-Reply-To: <Pine.LNX.4.58.0404201957340.2252@montezuma.fsmlabs.com>
Message-ID: <Pine.LNX.4.58.0404202046020.2252@montezuma.fsmlabs.com>
References: <Pine.LNX.4.58.0404201957340.2252@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Apr 2004, Zwane Mwaikambo wrote:

> I had trouble loading modules compiled with gcc3.3.3 because static unused
> variables were being discarded. Patch is against 2.4-bk

Oops, stale addressbook..
