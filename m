Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268001AbUJNWdQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268001AbUJNWdQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 18:33:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267916AbUJNWbx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 18:31:53 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:27372 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S267987AbUJNW1f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 18:27:35 -0400
Date: Fri, 15 Oct 2004 00:27:31 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: William Lee Irwin III <wli@holomorphy.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] move semaphore definitions to waitlock_types.h
In-Reply-To: <20041014220913.GB5607@holomorphy.com>
Message-ID: <Pine.LNX.4.61.0410150026280.877@scrub.home>
References: <Pine.LNX.4.61.0410142345020.29976@scrub.home>
 <20041014220913.GB5607@holomorphy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 14 Oct 2004, William Lee Irwin III wrote:

> ISTR removing the WAITQUEUE_DEBUG bits from all arches (AFAICT only m32r
> has any of that crap in 2.6.9-rc3); what kernel version this against?

2.6.8.1. It wasn't intended to be merged yet anyway.

bye, Roman
