Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266449AbUFVFIr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266449AbUFVFIr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 01:08:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266484AbUFVFIq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 01:08:46 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:2186 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S266449AbUFVFIp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 01:08:45 -0400
Date: Tue, 22 Jun 2004 07:20:37 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Peter Chubb <peterc@gelato.unsw.edu.au>
Cc: s0348365@sms.ed.ac.uk, Martin Schlemmer <azarah@nosferatu.za.org>,
       Sam Ravnborg <sam@ravnborg.org>,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] kbuild updates
Message-ID: <20040622052037.GA2722@mars.ravnborg.org>
Mail-Followup-To: Peter Chubb <peterc@gelato.unsw.edu.au>,
	s0348365@sms.ed.ac.uk, Martin Schlemmer <azarah@nosferatu.za.org>,
	Sam Ravnborg <sam@ravnborg.org>,
	Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
References: <539000871@toto.iv> <16599.36319.269156.432040@wombat.chubb.wattle.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16599.36319.269156.432040@wombat.chubb.wattle.id.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 22, 2004 at 11:39:43AM +1000, Peter Chubb wrote:
> 
> But can the include2/asm symlink be made a relative one, please?  I frequently
> build on one machine, then NFS-mount the build tree and run make
> modules_install somewhere else; I always at present have to convert
> that link to a relative symlink before doing so.

Patch is welcome. I recall having trouble with it when introducing it. But that
can have been caused by other issues.

	Sam
