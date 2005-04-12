Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262996AbVDLVqU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262996AbVDLVqU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 17:46:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263016AbVDLVm6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 17:42:58 -0400
Received: from main.gmane.org ([80.91.229.2]:44688 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S263015AbVDLVkc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 17:40:32 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Ed L Cashin <ecashin@coraid.com>
Subject: Re: AOE and large filesystems?
Date: Tue, 12 Apr 2005 17:37:01 -0400
Message-ID: <877jj73cea.fsf@coraid.com>
References: <pan.2005.04.05.20.44.39.37209@dcs.nac.uci.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
Cc: Dan Stromberg <strombrg@dcs.nac.uci.edu>
X-Gmane-NNTP-Posting-Host: adsl-34-234-30.asm.bellsouth.net
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
Cancel-Lock: sha1:r1BZeTg1xhSc4C1rJl/8tJFVKSE=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Stromberg <strombrg@dcs.nac.uci.edu> writes:

> Some questions for the list:
>
> 1) Is anyone on the list using AOE in production?

I don't know of any AoE users that read the lkml.  Except me, of
course.

> 2) Is anyone on the list using AOE in combination with md and/or LVM2?

Yes, most AoE users use md.  Many use LVM2, but a couple have had
trouble with striped volume groups.

> 3) Is anyone on the list using AOE on a 64 bit platform?

People are using AoE on 64 bit platforms and not reading the lkml.  :)

-- 
  Ed L Cashin <ecashin@coraid.com>

