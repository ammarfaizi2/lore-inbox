Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267620AbUG3F6c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267620AbUG3F6c (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 01:58:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267622AbUG3F6c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 01:58:32 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:45546 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S267620AbUG3F6W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 01:58:22 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: "Li, Shaohua" <shaohua.li@intel.com>
Date: Fri, 30 Jul 2004 15:58:12 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16649.58228.998580.791909@cse.unsw.edu.au>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: RE: Reporting "Yenta TI: socket 0000:02:03.0 no PCI interrupts. Fish. Please report."
In-Reply-To: message from Li, Shaohua on Friday July 30
References: <B44D37711ED29844BEA67908EAF36F03712EAF@pdsmsx401.ccr.corp.intel.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday July 30, shaohua.li@intel.com wrote:
> Hi,
> Looks like an ACPI bug. Could you please file a bug report in
> bugme.osdl.org, and please attach your 'acpidmp' and 'lspci -vv' output.
> 

grumble-grumble.... when is there going to be an Email interface for
bugme.osdl.org.... 

Using that web page is soooo klunky.  I would must rather just send
mail to new-bug@bugme.osdl.org or whatever.

However, bug 3132 has the information you asked for.

NeilBrown
