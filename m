Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262066AbVBJJV3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262066AbVBJJV3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 04:21:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262067AbVBJJV3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 04:21:29 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:29345 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S262066AbVBJJV0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 04:21:26 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Kim Holviala <kim@holviala.com>
Date: Thu, 10 Feb 2005 20:21:22 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16907.10130.293919.399727@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Spontaneous reboot with 2.6.10 and NFSD
In-Reply-To: message from Kim Holviala on Thursday February 10
References: <420B0FCD.4000801@holviala.com>
X-Mailer: VM 7.19 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday February 10, kim@holviala.com wrote:
> Anyway, I mount the export to a Linux client (tried with a few with 
> different 2.6 kernels and distros) and then start copying files from 
> clients CDROM to the server through NFS. After copying a few small 
> files, the first big one reboots the server.

Can you be specific about the size of the "big" file?
Also, what filesystem is being used on the server, what mount flags
(if any) and what export options.

Having some sort of console, whether VGA, serial, or network, to view
the Oops would be invaluable.

Thanks,
NeilBrown
