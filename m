Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265232AbUBIWmc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 17:42:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265242AbUBIWmc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 17:42:32 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:2233 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S265232AbUBIWma (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 17:42:30 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Thomas Horsten <thomas@horsten.com>
Date: Tue, 10 Feb 2004 09:40:32 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16424.3168.878709.152637@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, <linux-raid@vger.kernel.org>
Subject: Re: New mailing list for 2.6 Medley RAID (Silicon Image 3112 etc.)
 BIOS RAID development
In-Reply-To: message from Thomas Horsten on Monday February 9
References: <20040209121144.GA24503@devserv.devel.redhat.com>
	<Pine.LNX.4.40.0402091756380.13341-100000@jehova.dsm.dk>
X-Mailer: VM 7.18 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday February 9, thomas@horsten.com wrote:
> 
> For Medley RAID it's pretty straightforward to map striped sets, but how
> to deal with ataraids like Highpoint where they use non-standard zone
> models for the RAID0 sets?

Can you point me at documentation of code that gives the details of
this "non-standard zone model" ??

NeilBrown
