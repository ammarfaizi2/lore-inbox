Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261363AbUKNWwh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261363AbUKNWwh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 17:52:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261360AbUKNWuO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 17:50:14 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:8929 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261363AbUKNWst (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 17:48:49 -0500
Subject: Re: Compiling RHEL WS Kernels
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Paul G. Allen" <pgallen@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <bd8e30a404111407527403c134@mail.gmail.com>
References: <200411141210.iAECAIgd011479@harpo.it.uu.se>
	 <bd8e30a404111407527403c134@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1100468745.25624.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 14 Nov 2004 21:45:46 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2004-11-14 at 15:52, Paul G. Allen wrote:
> Stupid, stupid, stupid....
> 
> ....I forgot mrproper. I'm so used to not having to use it that I
> forgot. /me feels like an idiot. That said, the stock kernel should
> have recognized my USB devices, LCD resolution, and touchpad like RH
> 9.0 did without having to re-compile (but that's RH's problem, not
> this list).

Install kernel-unsupported. Note LCD reading is an X matter

