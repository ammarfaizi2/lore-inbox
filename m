Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265396AbTB0PwI>; Thu, 27 Feb 2003 10:52:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265414AbTB0PwI>; Thu, 27 Feb 2003 10:52:08 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:50743 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S265396AbTB0PwG>; Thu, 27 Feb 2003 10:52:06 -0500
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: fastboot@osdl.org,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Andy Pfiffer <andyp@osdl.org>
Subject: Re: [KEXEC][2.5.63] Partially tested patches available
References: <1046220814.27557.7.camel@andyp.pdx.osdl.net>
	<m11y1ulz79.fsf@frodo.biederman.org> <7350000.1046361606@[10.10.2.4]>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 27 Feb 2003 09:01:56 -0700
In-Reply-To: <7350000.1046361606@[10.10.2.4]>
Message-ID: <m1wujllnkb.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@aracnet.com> writes:

> >> There were additional syscall hijinks in the merge to 2.5.63, so anyone
> >> that uses this patch set will need to recompile their kexec tools.
> > 
> > Along with all of the usual craziness of life my brother has been
> > staying with me the last month or so, and my amount of free
> > time to actual work on kexec has been less then I like.
> > 
> > We need to get up some steam and see what it will take for Linus
> > to notice and actually get this patch included.
> 
> Could you confirm that the patches are released under the GPL, and have no
> patent encumberances that you know of? That will enable me to integrate
> them and get more people to work on it ...

I though I had.  But yes all of the code is released under GPL version 2
as specified by the kernel copying file.

Eric
