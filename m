Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932249AbWHBVxi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932249AbWHBVxi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 17:53:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932252AbWHBVxh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 17:53:37 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:57301 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932248AbWHBVxg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 17:53:36 -0400
Subject: Re: [PATCH] LSM: remove BSD secure level security module
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Chris Wright <chrisw@sous-sol.org>
Cc: Andrew Morton <akpm@osdl.org>, Michael Halcrow <mhalcrow@us.ibm.com>,
       serue@us.ibm.com, Stephen Smalley <sds@tycho.nsa.gov>,
       Davi Arnaut <davi.arnaut@gmail.com>, jmorris@namei.org,
       linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
In-Reply-To: <20060802180708.GQ2654@sequoia.sous-sol.org>
References: <20060802180708.GQ2654@sequoia.sous-sol.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 02 Aug 2006 23:10:35 +0100
Message-Id: <1154556635.23655.32.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-08-02 am 11:07 -0700, ysgrifennodd Chris Wright:
> This code has suffered from broken core design and lack of developer
> attention.  Broken security modules are too dangerous to leave around.
> It is time to remove this one.

Given SELinux can perform and implement the same type of policies

Acked-by: Alan Cox <alan@redhat.com>

