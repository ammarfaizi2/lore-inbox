Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262423AbUKVWSG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262423AbUKVWSG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 17:18:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262437AbUKVWPw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 17:15:52 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:20357 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262412AbUKVWOQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 17:14:16 -0500
Date: Mon, 22 Nov 2004 15:36:54 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Philippe Troin <phil@fifi.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: APM suspend/resume ceased to work with 2.4.28
Message-ID: <20041122173654.GA31848@logos.cnet>
References: <87zn1amuov.fsf@ceramic.fifi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zn1amuov.fsf@ceramic.fifi.org>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 21, 2004 at 07:25:20PM -0800, Philippe Troin wrote:
> Seen on a Dell Inspiron 3800 with BIOS revision A17.
> 
> APM suspend/resume works perfectly with 2.4.27 (or at least, as well
> as APM can).
> 
> Since I did not see any differences in arch/i386/kernel/apm.c between
> .27 and .28, I'm at loss to explain the problem.

Guess: Are you using ACPI ? 

:(
