Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265975AbUAUQxW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 11:53:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265977AbUAUQxW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 11:53:22 -0500
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:39309 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S265975AbUAUQxV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 11:53:21 -0500
Subject: Re: [patch] selinux build fix
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Gerd Knorr <kraxel@bytesex.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Kernel List <linux-kernel@vger.kernel.org>,
       James Morris <jmorris@redhat.com>
In-Reply-To: <20040121161331.GA2531@bytesex.org>
References: <20040121161331.GA2531@bytesex.org>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1074703969.9767.144.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-1) 
Date: Wed, 21 Jan 2004 11:52:49 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-01-21 at 11:13, Gerd Knorr wrote:
> trivial one: uses __init and thus needs linux/init.h

Thanks for the fix.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

