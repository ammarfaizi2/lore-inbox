Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261231AbVCAELZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261231AbVCAELZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 23:11:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261232AbVCAELZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 23:11:25 -0500
Received: from mx1.redhat.com ([66.187.233.31]:36283 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261231AbVCAELW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 23:11:22 -0500
Date: Mon, 28 Feb 2005 23:11:15 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Alexander Nyberg <alexn@dsv.su.se>
cc: akpm@osdl.org, <linux-kernel@vger.kernel.org>, <sds@epoch.ncsc.mil>
Subject: Re: [PATCH] SELinux: Leak in error path
In-Reply-To: <1109637172.3839.11.camel@boxen>
Message-ID: <Xine.LNX.4.44.0502282310570.26032-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Mar 2005, Alexander Nyberg wrote:

> There's a leak here in the first error path.
> 
> Found by the Coverity tool.
> 
> Signed-off-by: Alexander Nyberg <alexn@dsv.su.se>

Signed-off-by: James Morris <jmorris@redhat.com>

-- 
James Morris
<jmorris@redhat.com>


