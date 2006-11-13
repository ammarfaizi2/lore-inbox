Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755294AbWKMRyd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755294AbWKMRyd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 12:54:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755297AbWKMRyd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 12:54:33 -0500
Received: from mail.kroah.org ([69.55.234.183]:32391 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1755294AbWKMRyc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 12:54:32 -0500
Date: Mon, 13 Nov 2006 09:16:12 -0800
From: Greg KH <greg@kroah.com>
To: Michael Holzheu <HOLZHEU@de.ibm.com>
Cc: Ingo Oeser <ioe-lkml@rameria.de>, linux-kernel@vger.kernel.org,
       mschwid2@de.ibm.com, pavel@ucw.cz,
       Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: How to document dimension units for virtual files?
Message-ID: <20061113171612.GA14976@kroah.com>
References: <20061110065336.GA13646@kroah.com> <OF6928B06C.594331CB-ON41257222.0035C1AB-41257222.003747B5@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF6928B06C.594331CB-ON41257222.0035C1AB-41257222.003747B5@de.ibm.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 10, 2006 at 11:03:48AM +0100, Michael Holzheu wrote:
> At least for our s390_hypfs I would like to use the suggested naming
> scheme. It is new and therefore not burdened with other naming
> conventions. Ok?
> 
> So, no "Documentation/filesystems/ExportData" patch?

For now, I would not think so.  Just document the file units in the
Documentation/ABI/ directory and you should be fine.

thanks,

greg k-h
