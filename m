Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030204AbVKHHws@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030204AbVKHHws (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 02:52:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965397AbVKHHws
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 02:52:48 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:19913 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S965390AbVKHHwr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 02:52:47 -0500
Date: Tue, 8 Nov 2005 09:52:46 +0200 (EET)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Matthew Dobson <colpatch@us.ibm.com>
cc: kernel-janitors@lists.osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/8] Use 'nid' in slab.c
In-Reply-To: <436FF640.6070306@us.ibm.com>
Message-ID: <Pine.LNX.4.58.0511080952250.10193@sbz-30.cs.Helsinki.FI>
References: <436FF51D.8080509@us.ibm.com> <436FF640.6070306@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Nov 2005, Matthew Dobson wrote:
> We refer to a node number as: "nodeid", "node", "nid", and possibly other
> names.  Let's choose one, and I choose "nid".

Such a pity as nodeid is much more readable...

			Pekka
