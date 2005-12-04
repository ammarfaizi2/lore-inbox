Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750803AbVLDDkQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750803AbVLDDkQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 22:40:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751307AbVLDDkQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 22:40:16 -0500
Received: from lakshmi.addtoit.com ([198.99.130.6]:28175 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S1750803AbVLDDkO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 22:40:14 -0500
Date: Sat, 3 Dec 2005 23:32:05 -0500
From: Jeff Dike <jdike@addtoit.com>
To: Paulo da Silva <psdasilva@esoterica.pt>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Cannot run linux 2.6.14.3 UML on a x86_64
Message-ID: <20051204043205.GA15425@ccure.user-mode-linux.org>
References: <43924B2C.9000300@esoterica.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43924B2C.9000300@esoterica.pt>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 04, 2005 at 01:49:32AM +0000, Paulo da Silva wrote:
> I got the following boot output from
> uml linux 2.6.14.3 from a x86_64.

Are you using a 32 or 64-bit filesystem?

And why it is running in tt mode?  CONFIG_MODE_SKAS is disabled?

				Jeff
