Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269085AbUJWDFU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269085AbUJWDFU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 23:05:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269297AbUJWDDT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 23:03:19 -0400
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:42431
	"EHLO animx.eu.org") by vger.kernel.org with ESMTP id S269256AbUJWC6T
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 22:58:19 -0400
Date: Fri, 22 Oct 2004 23:03:56 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: The naming wars continue...
Message-ID: <20041023030356.GA5005@animx.eu.org>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0410221431180.2101@ppc970.osdl.org> <20041022234631.GF28904@waste.org> <20041023011549.GK17038@holomorphy.com> <Pine.LNX.4.58.0410221821030.2101@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0410221821030.2101@ppc970.osdl.org>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The fact is, Linux naming has always sucked. Well, at least the versioning 
> I've used. Others tend to be more organized. Me, I'm the "artistic" type, 
> so I sometimes try to do something new, and invariably stupid. 

Given that the versioning was supposedly <major>.<minor>.<patchlevel> and
the difference between 2.4 and 2.6 was substantial, why not just bump
<major> instead of the minor.  Then we'd have 3.0, 3.1, 4.0, 4.1.1 (for
stupid mistakes).  Isn't it time we move off the 2.x series and start
thinking of the 3.x series?

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
