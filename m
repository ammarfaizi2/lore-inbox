Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751463AbWFTW4R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751463AbWFTW4R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 18:56:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751466AbWFTW4R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 18:56:17 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:38786 "EHLO
	sequoia.sous-sol.org") by vger.kernel.org with ESMTP
	id S1751463AbWFTW4R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 18:56:17 -0400
Date: Tue, 20 Jun 2006 15:55:22 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: Jeff Dike <jdike@addtoit.com>
Cc: stable@kernel.org, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [stable] [-stable PATCH] UML - fix uptime
Message-ID: <20060620225522.GK22737@sequoia.sous-sol.org>
References: <200606202225.k5KMP3U5006871@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606202225.k5KMP3U5006871@ccure.user-mode-linux.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jeff Dike (jdike@addtoit.com) wrote:
> The use of unsigned instead of unsigned here broke the calculations on
             ^^^^^^^^            ^^^^^^^^
Hard to imagine how that would cause a problem ;-)

Queued for -stable, thanks.
-chris
