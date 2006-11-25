Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966962AbWKYS2R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966962AbWKYS2R (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 13:28:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966971AbWKYS2R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 13:28:17 -0500
Received: from ns1.suse.de ([195.135.220.2]:20715 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S966962AbWKYS2Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 13:28:16 -0500
From: Andi Kleen <ak@suse.de>
To: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch] X86: add sysctl for kstack_depth_to_print
Date: Sat, 25 Nov 2006 19:27:44 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel <linux-kernel@vger.kernel.org>
References: <200611251243_MC3-1-D2DA-5EB0@compuserve.com>
In-Reply-To: <200611251243_MC3-1-D2DA-5EB0@compuserve.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611251927.47367.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 25 November 2006 18:40, Chuck Ebbert wrote:
> Add sysctl for kstack_depth_to_print. This lets users change
> the amount of raw stack data printed in dump_stack() without
> having to reboot.

Added thanks
-Andi
