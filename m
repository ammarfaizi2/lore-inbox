Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262012AbVBUQU0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262012AbVBUQU0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 11:20:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262021AbVBUQU0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 11:20:26 -0500
Received: from adsl-67-120-171-161.dsl.lsan03.pacbell.net ([67.120.171.161]:14096
	"HELO linuxace.com") by vger.kernel.org with SMTP id S262012AbVBUQUU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 11:20:20 -0500
Date: Mon, 21 Feb 2005 08:20:19 -0800
From: Phil Oester <kernel@linuxace.com>
To: Piotr Kowalczyk <poe@koba.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: dst cache overflow, again
Message-ID: <20050221162019.GA31893@linuxace.com>
References: <4219E06E.6030700@koba.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4219E06E.6030700@koba.pl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2005 at 02:21:50PM +0100, Piotr Kowalczyk wrote:
> Hi all,
> 
> I'm suffering from destination cache overflow on router running kernel 
> 2.6.10. This wouldn't be anything special if not different numbers 
> reported by slabinfo and the real state. It's worth to mention that 
> there was no problems with old 2.4.x here.

Use 2.6.11-rc4 -- this problem has been fixed there.

Phil
