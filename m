Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262917AbVDAWOR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262917AbVDAWOR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 17:14:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262916AbVDAWL3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 17:11:29 -0500
Received: from colo.lackof.org ([198.49.126.79]:26559 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S262918AbVDAWJj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 17:09:39 -0500
Date: Fri, 1 Apr 2005 15:11:31 -0700
From: Grant Grundler <grundler@parisc-linux.org>
To: Jim Gifford <maillist@jg555.com>
Cc: Grant Grundler <grundler@parisc-linux.org>,
       LKML <linux-kernel@vger.kernel.org>, jgarzik@pobox.com,
       pdh@colonel-panic.org
Subject: Re: 64bit build of tulip driver
Message-ID: <20050401221131.GB11749@colo.lackof.org>
References: <424AE9E0.8040601@jg555.com> <20050331161206.GB19219@colo.lackof.org> <424CC566.3080007@jg555.com> <20050401065120.GD29734@colo.lackof.org> <424D7AE9.5050100@jg555.com> <20050401182609.GB8178@colo.lackof.org> <424DADBD.9010509@jg555.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <424DADBD.9010509@jg555.com>
X-Home-Page: http://www.parisc-linux.org/
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 01, 2005 at 12:23:25PM -0800, Jim Gifford wrote:
> Grant,
>    Thank you, I took your driver as a reference and added in the cobalt 
> specifics to the eeprom.c file, works perfectly now.

Cool! very welcome.

Can you do me a favor and submit a diff of all the tulip changes
you have at this point back to lkml (and whatever other lists are cc'd)?

jgarzik might accept your bits and ignore the parts that have been
submitted/rejected before.  But whatever you post will get archived
with this thread for others to find in the future.

thanks,
grant
