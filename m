Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261556AbULYTLd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261556AbULYTLd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Dec 2004 14:11:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261553AbULYTLd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Dec 2004 14:11:33 -0500
Received: from are.twiddle.net ([64.81.246.98]:53636 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id S261556AbULYTLc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Dec 2004 14:11:32 -0500
Date: Sat, 25 Dec 2004 11:11:26 -0800
From: Richard Henderson <rth@twiddle.net>
To: domen@coderock.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch 1/4] delete unused file
Message-ID: <20041225191126.GA3219@twiddle.net>
Mail-Followup-To: domen@coderock.org, linux-kernel@vger.kernel.org
References: <20041225134120.050934DC0EB@golobica.uni-mb.si>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041225134120.050934DC0EB@golobica.uni-mb.si>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 25, 2004 at 02:41:28PM +0100, domen@coderock.org wrote:
>  kj/arch/alpha/lib/dbg_stackcheck.S |   27 ---------------------------

As should be obvious from the "dbg" prefix, these are debugging aids.
Do not remove any of them.


r~
