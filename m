Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751421AbWBVUk0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751421AbWBVUk0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 15:40:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751423AbWBVUkZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 15:40:25 -0500
Received: from smtp.osdl.org ([65.172.181.4]:32704 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751421AbWBVUkY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 15:40:24 -0500
Date: Wed, 22 Feb 2006 12:39:49 -0800
From: Andrew Morton <akpm@osdl.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: linux-kernel@vger.kernel.org, jmorris@namei.org
Subject: Re: [patch 1/1] selinux: Disable automatic labeling of new inodes
 when no policy is loaded
Message-Id: <20060222123949.29a5cd2e.akpm@osdl.org>
In-Reply-To: <1140636986.31467.276.camel@moss-spartans.epoch.ncsc.mil>
References: <1140636986.31467.276.camel@moss-spartans.epoch.ncsc.mil>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Smalley <sds@tycho.nsa.gov> wrote:
>
> This patch disables the automatic labeling of new inodes on disk
>  when no policy is loaded.  Please apply.
>

What is the reason for this change, and what will its effects be?
