Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264368AbTFKLPW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 07:15:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264370AbTFKLPW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 07:15:22 -0400
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:30214 "EHLO
	krusty.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S264368AbTFKLPT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 07:15:19 -0400
Date: Wed, 11 Jun 2003 13:28:59 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Compiling kernel with SuSE 8.2/gcc 3.3
Message-ID: <20030611112859.GA9031@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <3EE6B7A2.3000606@austin.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EE6B7A2.3000606@austin.rr.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Jun 2003, Steve French wrote:

> Stephan von Krawczynski <skraw@ithnet.com> writes:
> 
> >during tests with latest SuSE distro 8.2 compiling 2.4.21-pre6 showed a 
> >lot of
> >"comparison between signed and unsigned" warnings. It looks like SuSE 
> >ships gcc
> 
> I also noticed lots of compiler warnings with gcc 3.3, now default in SuSE, 
> and cleaned up most of them for the cifs vfs but there are a few that just
> look wrong for gcc to spit out warnings on.   For example the following
> local variable definition and the similar ones in the same file
> (fs/cifs/inode.c):

Did you try with a release version of gcc 3.3? The one shipped on SuSE
Linux 8.2 media/FTP is a pre-release version.

(If SuSE would only ship patch-level updates to such essential
components, say, 3.2.2 for 8.1 and the released 3.3 for 8.2.)

-- 
Matthias Andree
