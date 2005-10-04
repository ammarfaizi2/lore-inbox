Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751171AbVJDAzL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751171AbVJDAzL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 20:55:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751176AbVJDAzL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 20:55:11 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:42920 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1751171AbVJDAzJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 20:55:09 -0400
Date: Mon, 3 Oct 2005 17:54:38 -0700
From: Paul Jackson <pj@sgi.com>
To: Jean Delvare <khali@linux-fr.org>
Cc: greg@kroah.com, torvalds@osdl.org, akpm@osdl.org, jgarzik@pobox.com,
       rdunlap@xenotime.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Document patch subject line better
Message-Id: <20051003175438.6803539c.pj@sgi.com>
In-Reply-To: <20051003230235.55516671.khali@linux-fr.org>
References: <20051003072910.14726.10100.sendpatchset@jackhammer.engr.sgi.com>
	<Pine.LNX.4.64.0510030805380.31407@g5.osdl.org>
	<20051003085414.05468a2b.pj@sgi.com>
	<20051003160452.GA9107@kroah.com>
	<20051003230235.55516671.khali@linux-fr.org>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean wrote:
> This only prevents quilt from stripping the "---" line

This patch, plus the ~/.quiltrc option:

	QUILT_NO_DIFF_INDEX=1

do what I need.  Thanks for the quick response.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
