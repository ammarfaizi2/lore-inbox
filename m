Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262568AbTFZVA4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 17:00:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262593AbTFZVA4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 17:00:56 -0400
Received: from are.twiddle.net ([64.81.246.98]:31398 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id S262568AbTFZVAz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 17:00:55 -0400
Date: Thu, 26 Jun 2003 14:15:00 -0700
From: Richard Henderson <rth@twiddle.net>
To: Marc Zyngier <mzyngier@freesurf.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ALPHA][2.5.7x] Problems with execve assembly rewriting
Message-ID: <20030626211500.GA9263@twiddle.net>
Mail-Followup-To: Marc Zyngier <mzyngier@freesurf.fr>,
	linux-kernel@vger.kernel.org
References: <wrp4r2cpqye.fsf@hina.wild-wind.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wrp4r2cpqye.fsf@hina.wild-wind.fr.eu.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 26, 2003 at 09:40:57PM +0200, Marc Zyngier wrote:
> Let me know if I can do something to help debugging the thing.

Check gp for the binary and verify that it's wrong.

What binutils version are you using?


r~
