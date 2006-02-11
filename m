Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750823AbWBKW4J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750823AbWBKW4J (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Feb 2006 17:56:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750813AbWBKW4J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Feb 2006 17:56:09 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:52693 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750829AbWBKW4I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Feb 2006 17:56:08 -0500
Date: Sat, 11 Feb 2006 16:56:04 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: paulkf@microgate.com, alan@lxorguk.ukuu.org.uk
Subject: Re: + tty-buffering-stall-fix.patch added to -mm tree
Message-ID: <20060211225604.GA3759@sergelap.austin.ibm.com>
References: <200602100452.k1A4qRNF031102@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602100452.k1A4qRNF031102@shell0.pdx.osdl.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting akpm@osdl.org (akpm@osdl.org):
> 
> The patch titled
> 
>      tty buffering stall fix
> 
> has been added to the -mm tree.  Its filename is
> 
>      tty-buffering-stall-fix.patch

Dunno if you're looking for confirmation, but this fixes the console on
my power5 partition.  I'd been waiting to report console locking up until
I could make sure it wasn't a local config (ie selinux or lib) problem.

thanks,
-serge
