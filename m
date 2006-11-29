Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758831AbWK2NPX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758831AbWK2NPX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 08:15:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758835AbWK2NPX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 08:15:23 -0500
Received: from ns.suse.de ([195.135.220.2]:55272 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1758831AbWK2NPW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 08:15:22 -0500
From: Andi Kleen <ak@suse.de>
To: "Jan Beulich" <jbeulich@novell.com>
Subject: Re: [PATCH] use probe_kernel_address in Dwarf2 unwinder
Date: Wed, 29 Nov 2006 14:15:13 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
References: <456D79AB.76E4.0078.0@novell.com>
In-Reply-To: <456D79AB.76E4.0078.0@novell.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611291415.13169.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 29 November 2006 12:14, Jan Beulich wrote:
> Use probe_kernel_address() instead of __get_user() in Dwarf2 unwinder.

I had already done this here. Thanks.

-Andi
