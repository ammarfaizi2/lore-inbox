Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264706AbTB0Ll0>; Thu, 27 Feb 2003 06:41:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264811AbTB0LlM>; Thu, 27 Feb 2003 06:41:12 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:36917 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S264790AbTB0Lkm>; Thu, 27 Feb 2003 06:40:42 -0500
To: Andy Pfiffer <andyp@osdl.org>
Cc: fastboot@osdl.org,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Suparna Bhattacharya <suparna@in.ibm.com>
Subject: Re: [KEXEC][2.5.63] Partially tested patches available
References: <1046220814.27557.7.camel@andyp.pdx.osdl.net>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 27 Feb 2003 04:50:34 -0700
In-Reply-To: <1046220814.27557.7.camel@andyp.pdx.osdl.net>
Message-ID: <m11y1ulz79.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Pfiffer <andyp@osdl.org> writes:

> Eric,
> 
> I have carried forward the kexec patch set to 2.5.63.  I have checked it
> on a 1-way system, and 2-way tests are still pending.

Cool.
 
> There were additional syscall hijinks in the merge to 2.5.63, so anyone
> that uses this patch set will need to recompile their kexec tools.

Along with all of the usual craziness of life my brother has been
staying with me the last month or so, and my amount of free
time to actual work on kexec has been less then I like.

We need to get up some steam and see what it will take for Linus
to notice and actually get this patch included.

Eric
