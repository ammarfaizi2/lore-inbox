Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261533AbVCNFIq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261533AbVCNFIq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 00:08:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261479AbVCNFIq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 00:08:46 -0500
Received: from rproxy.gmail.com ([64.233.170.200]:25487 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261533AbVCNFGc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 00:06:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=s8MhK7d/Zhyi5lrg22nqAYlQ8tF7sA9WIfHrBq6v12oUuziu9kUhLnKEgM1zKLiOKTYQkP3jSyhdSXEAtiVFJLJHQlMo3DUOMofDycNx2qjQo8N1Tmc3VGANWfOvWCnGKUhsludPPXwIO3mD2u5Mt78jPd/HSPFiP4YzNII2PJk=
Message-ID: <530468570503132006284cb62e@mail.gmail.com>
Date: Sun, 13 Mar 2005 21:06:32 -0700
From: Jesse Allen <the3dfxdude@gmail.com>
Reply-To: Jesse Allen <the3dfxdude@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: More trouble with i386 EFLAGS and ptrace
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland, Daniel,

I was the one that reported the ptrace problems which caused all that
hoopla in Nov and Dec.  I have tested your new patches and find that
there are no new regressions.

Jesse
