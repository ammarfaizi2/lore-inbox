Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932494AbWAKUNu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932494AbWAKUNu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 15:13:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932497AbWAKUNu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 15:13:50 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:54229 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932494AbWAKUNu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 15:13:50 -0500
Date: Wed, 11 Jan 2006 12:13:43 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: yhlu <yhlu.kernel@gmail.com>
cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: can not compile in the latest git
In-Reply-To: <86802c440601111021m7cb40881m7206d9342534f844@mail.gmail.com>
Message-ID: <Pine.LNX.4.62.0601111213270.24355@schroedinger.engr.sgi.com>
References: <86802c440601111021m7cb40881m7206d9342534f844@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Jan 2006, yhlu wrote:

> : undefined reference to `putback_lru_pages'
> make: *** [.tmp_vmlinux1] Error 1

Please post your .config file.

