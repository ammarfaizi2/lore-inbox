Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261223AbULMOmL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261223AbULMOmL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 09:42:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261225AbULMOmL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 09:42:11 -0500
Received: from fsmlabs.com ([168.103.115.128]:40139 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S261223AbULMOmF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 09:42:05 -0500
Date: Mon, 13 Dec 2004 07:38:03 -0700 (MST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Hans Kristian Rosbach <hk@isphuset.no>
cc: Andrew Morton <akpm@osdl.org>, Con Kolivas <kernel@kolivas.org>,
       andrea@suse.de, pavel@suse.cz,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: dynamic-hz
In-Reply-To: <1102936790.17227.24.camel@linux.local>
Message-ID: <Pine.LNX.4.61.0412130737330.22212@montezuma.fsmlabs.com>
References: <20041211142317.GF16322@dualathlon.random>  <20041212163547.GB6286@elf.ucw.cz>
  <20041212222312.GN16322@dualathlon.random> <41BCD5F3.80401@kolivas.org> 
 <20041213030237.5b6f6178.akpm@osdl.org> <1102936790.17227.24.camel@linux.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Dec 2004, Hans Kristian Rosbach wrote:

> Is there any recommended lower bound setting?
> Would there be a point in recommending lower settings for desktops
> running only text consoles opposed to X desktops?

You could probably go as low as 50 without noticing anything on text only 
consoles.

