Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264850AbUFHGJE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264850AbUFHGJE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 02:09:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264851AbUFHGJE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 02:09:04 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:37898 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S264850AbUFHGJB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 02:09:01 -0400
Subject: Re: Flushing the swap
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Hal Nine <hal9@cyberspace.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200406072234.SAA07853@grex.cyberspace.org>
References: <200406072234.SAA07853@grex.cyberspace.org>
Content-Type: text/plain
Date: Tue, 08 Jun 2004 08:09:09 +0200
Message-Id: <1086674949.1658.0.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.9.1 (1.5.9.1-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-06-07 at 18:34 -0400, Hal Nine wrote:
> Is there any way of making linux flush out all pages out of swap
> space?  I want to have 0K of used swap space.

Maybe?

# swapoff -a
# swapon -a


