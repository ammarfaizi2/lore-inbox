Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932478AbVKLTij@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932478AbVKLTij (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 14:38:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932477AbVKLTij
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 14:38:39 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:19933 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932478AbVKLTii (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 14:38:38 -0500
Subject: Re: Modules are missed while compiling the same version of kernel
From: Lee Revell <rlrevell@joe-job.com>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Neo Jia <cjia@cse.unl.edu>, linux-kernel@vger.kernel.org
In-Reply-To: <9a8748490511120634h64a74359s59e4eab3ca8fdda2@mail.gmail.com>
References: <43756131.5020702@cse.unl.edu>
	 <9a8748490511120634h64a74359s59e4eab3ca8fdda2@mail.gmail.com>
Content-Type: text/plain
Date: Sat, 12 Nov 2005 14:09:51 -0500
Message-Id: <1131822591.15223.5.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-11-12 at 15:34 +0100, Jesper Juhl wrote:
> You are adding the -rt patchset, the changes in there could also
> account for some of the difference although I must admit I don't know
> exactely what changes the -rt patchset makes - I've never really
> looked at it. 

Actually he's talking about RTLinux, which is a commercial product.  He
needs to contact his support rep.  Or depending on the nature of his RT
constraints, consider the -rt kernel.

Lee

