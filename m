Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261954AbVCHKHD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261954AbVCHKHD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 05:07:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261949AbVCHKEW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 05:04:22 -0500
Received: from mx1.redhat.com ([66.187.233.31]:11489 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261956AbVCHKDb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 05:03:31 -0500
Date: Tue, 8 Mar 2005 05:03:24 -0500
From: Alan Cox <alan@redhat.com>
To: Luc Saillard <luc@saillard.org>
Cc: Greg KH <greg@kroah.com>, alan@redhat.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       torvalds@osdl.org
Subject: Re: [PATCH] Restore PWC driver
Message-ID: <20050308100324.GD30673@devserv.devel.redhat.com>
References: <200503072216.j27MGLqR024373@hera.kernel.org> <20050308052643.GA16222@kroah.com> <20050308081508.GD31674@sd291.sivit.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050308081508.GD31674@sd291.sivit.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 08, 2005 at 09:15:08AM +0100, Luc Saillard wrote:
> > 	- the coding style
> oops (anyone have a vim syntax file for lkml indenting ?)

indent -kr -i8 -bri0 -l255 

comes very close as a starter. If you do that don't mix it with any actual
code changes.

> > 	- drop that unneeded changelog file
