Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267358AbUHaIJ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267358AbUHaIJ2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 04:09:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267370AbUHaIJ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 04:09:28 -0400
Received: from holomorphy.com ([207.189.100.168]:5819 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267358AbUHaIJY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 04:09:24 -0400
Date: Tue, 31 Aug 2004 01:09:16 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Eric Valette <eric.valette@free.fr>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9-rc1-mm2 : compilation error in kernel/wait.c
Message-ID: <20040831080916.GK5492@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Eric Valette <eric.valette@free.fr>, Andrew Morton <akpm@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <41343136.6080208@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41343136.6080208@free.fr>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 31, 2004 at 10:05:10AM +0200, Eric Valette wrote:
> kernel/wait.c:156: error: conflicting types for '__wait_on_bit'
> include/linux/wait.h:143: error: previous declaration of '__wait_on_bit' 
> was here
> kernel/wait.c:156: error: conflicting types for '__wait_on_bit'
> include/linux/wait.h:143: error: previous declaration of '__wait_on_bit' 
> was here
> kernel/wait.c:170: error: conflicting types for '__wait_on_bit_lock'
> include/linux/wait.h:144: error: previous declaration of 
> '__wait_on_bit_lock' was here
> kernel/wait.c:170: error: conflicting types for '__wait_on_bit_lock'
> include/linux/wait.h:144: error: previous declaration of 
> '__wait_on_bit_lock' was here
> make[2]: *** [kernel/wait.o] Error 1
> make[1]: *** [kernel] Error 2

I very distinctly recall compiling and booting these...


-- wli
