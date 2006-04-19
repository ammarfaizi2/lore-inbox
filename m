Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751008AbWDSRoK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751008AbWDSRoK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 13:44:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751017AbWDSRoJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 13:44:09 -0400
Received: from smtprelay01.ispgateway.de ([80.67.18.13]:25519 "EHLO
	smtprelay01.ispgateway.de") by vger.kernel.org with ESMTP
	id S1751008AbWDSRoI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 13:44:08 -0400
From: Ingo Oeser <ioe-lkml@rameria.de>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: A missing i_mutex in rename? (Linux kernel 2.6.latest)
Date: Wed, 19 Apr 2006 19:41:53 +0200
User-Agent: KMail/1.9.1
References: <Pine.LNX.4.64.0604191102260.17373@hermes-1.csi.cam.ac.uk> <20060419121826.GI24104@parisc-linux.org> <Pine.LNX.4.64.0604191328160.12158@hermes-1.csi.cam.ac.uk>
In-Reply-To: <Pine.LNX.4.64.0604191328160.12158@hermes-1.csi.cam.ac.uk>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604191941.54398.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, 19. April 2006 14:51, you wrote:
> [...] I 
> doubt sys_rename() is a very often invoked system call.

Not if you are handling emails.

install courier-imapd and type
man maildir


Regards

Ingo Oeser
