Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270707AbTHOTCQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 15:02:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270700AbTHOSeJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 14:34:09 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:50982 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S270739AbTHOSbH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 14:31:07 -0400
Date: Fri, 15 Aug 2003 19:29:40 +0100
From: Dave Jones <davej@redhat.com>
To: Jan Rychter <jan@rychter.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Centrino support
Message-ID: <20030815182940.GC9681@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Jan Rychter <jan@rychter.com>, linux-kernel@vger.kernel.org
References: <m2wude3i2y.fsf@tnuctip.rychter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m2wude3i2y.fsf@tnuctip.rychter.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 15, 2003 at 11:13:09AM -0700, Jan Rychter wrote:
 > From http://news.com.com/2100-1006-993896.html:
 > 
 >   Intel plans Linux support for Centrino
 > 
 >   Intel is working on Linux support for Centrino, its package of chips for
 >   mobile computers with wireless networking abilities, but the company
 >   hasn't yet decided how or when to release it.
 > 
 > That was on March 24, 2003.
 > 
 > Well, that was almost 5 months ago. So I figured I'd ask if there's any
 > progress -- so far the built-in wireless in my notebook still doesn't
 > work with Linux and the machine is monstrously power-hungry because
 > Linux doesn't scale the CPU frequency.

CPU frequency scaling is supported now at least. (Though you'll need
-ac for 2.4, or 2.6). Wireless is still unsupported AFAIK.

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
