Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265301AbUEZEjH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265301AbUEZEjH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 00:39:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265302AbUEZEjH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 00:39:07 -0400
Received: from fw.osdl.org ([65.172.181.6]:31405 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265301AbUEZEjC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 00:39:02 -0400
Date: Tue, 25 May 2004 21:35:40 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Paul Jackson <pj@sgi.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] remove message: POSIX conformance testing by UNIFIX
Message-Id: <20040525213540.4731c449.rddunlap@osdl.org>
In-Reply-To: <20040525213710.5414f1a8.pj@sgi.com>
References: <20040525205820.25338dd5.rddunlap@osdl.org>
	<20040525213710.5414f1a8.pj@sgi.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 May 2004 21:37:10 -0700 Paul Jackson <pj@sgi.com> wrote:

| > -	printk("POSIX conformance testing by UNIFIX\n");
| 
| That's a stubborn line.  Andrew already tried to remove it
| once, with a patch I believe he called:
| 
|   delete-posix-conformance-testing-by-unifix-message.patch
| 
| in his 2.6.6 *-mm series.  But that patch was neutered by
| some glitch.

OK, I didn't know what happened to it...
(That patch was from me also.)

| You're right - we have concensus on this change.

--
~Randy
