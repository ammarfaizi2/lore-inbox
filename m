Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750705AbWAPM02@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750705AbWAPM02 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 07:26:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750712AbWAPM02
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 07:26:28 -0500
Received: from cantor2.suse.de ([195.135.220.15]:15268 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750705AbWAPM01 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 07:26:27 -0500
From: Andi Kleen <ak@suse.de>
To: Akinobu Mita <mita@miraclelinux.com>
Subject: Re: [PATCH 2/3] use usual call trace format on x86-64
Date: Mon, 16 Jan 2006 13:22:41 +0100
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
References: <20060116121611.GA539@miraclelinux.com> <20060116121800.GC539@miraclelinux.com>
In-Reply-To: <20060116121800.GC539@miraclelinux.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601161322.41633.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 16 January 2006 13:18, Akinobu Mita wrote:
> Use print_symbol() to dump call trace.

Rejected.

-Andi
