Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261740AbUKUB45@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261740AbUKUB45 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 20:56:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261725AbUKUBzb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 20:55:31 -0500
Received: from mail.ocs.com.au ([202.147.117.210]:18372 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S261728AbUKUByw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 20:54:52 -0500
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: "Robin H. Johnson" <robbat2@gentoo.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Ksymoops and objdump/nm complain 'File format is ambiguous' - Patch included 
In-reply-to: Your message of "Wed, 17 Nov 2004 00:10:15 -0800."
             <20041117081015.GA14601@curie-int.orbis-terrarum.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 21 Nov 2004 12:54:43 +1100
Message-ID: <366.1101002083@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Nov 2004 00:10:15 -0800, 
"Robin H. Johnson" <robbat2@gentoo.org> wrote:
>Under certain binutils configurations (primarily when multiple targets
>are enabled), objdump and nm give an error 'File format is ambiguous'
>and require explicit specification of the target after listing the
>possible options. This break ksymoops badly.
>
>I've attached a patch ...

Patch included in ksymoops 2.4.10, thanks.

ftp://ftp.<country>.kernel.org/pub/linux/utils/kernel/ksymoops/v2.4

