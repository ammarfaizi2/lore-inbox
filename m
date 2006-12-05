Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760079AbWLEORt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760079AbWLEORt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 09:17:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760080AbWLEORt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 09:17:49 -0500
Received: from mx1.redhat.com ([66.187.233.31]:56137 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760079AbWLEORt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 09:17:49 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20061204192018.2a61814f.akpm@osdl.org> 
References: <20061204192018.2a61814f.akpm@osdl.org>  <1164205742.13434.4.camel@localhost> <20061122152559.72efd379.akpm@osdl.org> <1165286169.6023.1.camel@localhost> 
To: Andrew Morton <akpm@osdl.org>
Cc: Kasper Sandberg <lkml@metanurb.dk>,
       LKML Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: BUG? atleast >=2.6.19-rc5, x86 chroot on x86_64 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Tue, 05 Dec 2006 14:17:38 +0000
Message-ID: <4659.1165328258@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:

> Possibly one could work out what's going on by reverse-engineering x86_64
> ioctl command 0x82187201, but unfortunately I don't have time to do that. 

strace can do that.

David
