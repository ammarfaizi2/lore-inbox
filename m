Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262238AbUC1SSv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 13:18:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262322AbUC1SSv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 13:18:51 -0500
Received: from holomorphy.com ([207.189.100.168]:46742 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262238AbUC1SSq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 13:18:46 -0500
Date: Sun, 28 Mar 2004 10:18:45 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Joey Parrish <joey@nicewarrior.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] no Walken during fb boot
Message-ID: <20040328181845.GB791@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Joey Parrish <joey@nicewarrior.org>, linux-kernel@vger.kernel.org
References: <20040328174718.GA12681@nicewarrior.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040328174718.GA12681@nicewarrior.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 28, 2004 at 11:47:18AM -0600, Joey Parrish wrote:
> I've noticed a bug in the fb system during boot.  (I'm running a
> stock 2.6.4 kernel, with the newer of the two radeonfb drivers
> compiled in statically.)  After the fb driver initializes, there
> is _never_ a boot logo featuring star of stage and screen,
> Mr. Christopher Walken.
> Included below is a patch to fix this issue.  (gzip'd, ~24kb)

I hereby nominate this patch for Patch of the Week (TM).


-- wli
