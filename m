Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751134AbWAYMK0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751134AbWAYMK0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 07:10:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751135AbWAYMK0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 07:10:26 -0500
Received: from mx2.suse.de ([195.135.220.15]:48518 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751134AbWAYMKZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 07:10:25 -0500
From: Andi Kleen <ak@suse.de>
To: Akinobu Mita <mita@miraclelinux.com>
Subject: Re: [PATCH 1/6] {set,clear,test}_bit() related cleanup
Date: Wed, 25 Jan 2006 12:46:33 +0100
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
References: <20060125112625.GA18584@miraclelinux.com> <20060125112857.GB18584@miraclelinux.com>
In-Reply-To: <20060125112857.GB18584@miraclelinux.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601251246.34314.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 25 January 2006 12:28, Akinobu Mita wrote:
> While working on these patch set, I found several possible cleanup
> on x86-64 and ia64.

Please don't send emails with that big cc lists [dropped most of them]

I applied the x86-64 bits. Thanks. Please send the ia64 bits separately
to the IA64 maintainer.

-Andi
