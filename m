Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268755AbUJPPR2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268755AbUJPPR2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 11:17:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268756AbUJPPR2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 11:17:28 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:13449 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S268755AbUJPPR0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 11:17:26 -0400
Date: Sat, 16 Oct 2004 19:17:04 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Erwin Schoenmakers <esc-solutions@planet.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: while building kernel 2.6.8.1. for Alpha (Miata)
Message-ID: <20041016191704.A20686@jurassic.park.msu.ru>
References: <417139A2.5090705@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <417139A2.5090705@planet.nl>; from esc-solutions@planet.nl on Sat, Oct 16, 2004 at 05:09:22PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 16, 2004 at 05:09:22PM +0200, Erwin Schoenmakers wrote:
> Do I need to install another version of the gnu compiler/assembler?
> I have installed:
>    gcc version 2.95.4
>    as version 2.12.90.0.1 using BFD version 2.12.90.0.1

Yes. Your toolchain is way too old.

Ivan.
