Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261816AbVFGS1s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261816AbVFGS1s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 14:27:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261819AbVFGS1s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 14:27:48 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:41195 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S261816AbVFGS1j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 14:27:39 -0400
Date: Tue, 7 Jun 2005 14:27:37 -0400
To: Bill Davidsen <davidsen@tmr.com>
Cc: Michael Thonke <iogl64nx@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Pentium-D support
Message-ID: <20050607182737.GR23621@csclub.uwaterloo.ca>
References: <42A5B80A.4040709@tmr.com> <42A5C8A3.2090202@gmail.com> <42A5DD47.5090000@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42A5DD47.5090000@tmr.com>
User-Agent: Mutt/1.3.28i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2005 at 01:45:43PM -0400, Bill Davidsen wrote:
> Okay, unless I can find an Intel-64 build of Fedora I'll have to do it 
> myself, but now that I know what option to use it's possible. Trust 
> Intel to have a 64 bit standard which isn't Itanium and isn't ..quite.. 
> AMD compatible.

It should be instructionset compatible (at least almost) but
optimization wise it is different since it is a very different design.

Certainly Debian's amd64 runs on both just fine, but recomends different
kernel builds for each (but also has one generic that runs on both).

Len Sorensen
