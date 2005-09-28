Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751247AbVI1Xqd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751247AbVI1Xqd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 19:46:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751248AbVI1Xqd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 19:46:33 -0400
Received: from hierophant.serpentine.com ([66.92.13.71]:23455 "EHLO
	demesne.serpentine.com") by vger.kernel.org with ESMTP
	id S1751247AbVI1Xqc (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 19:46:32 -0400
Subject: Re: 2.6.14-rc2: x86_64 SMP kernel crashes early during boot
From: "Bryan O'Sullivan" <bos@serpentine.com>
To: ak@suse.de, discuss@x86-64.org, Linux-kernel@vger.kernel.org
In-Reply-To: <1127949243.26892.41.camel@localhost.localdomain>
References: <1127949243.26892.41.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 28 Sep 2005 16:45:20 -0700
Message-Id: <1127951120.26892.53.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-09-28 at 16:14 -0700, Bryan O'Sullivan wrote:
> This is on a dual Opteron system, running Fedora Core 3.

The oops is slightly different with 2.6.14-rc1, but still very early
during boot, and still in mm/slab.c.

	<b

