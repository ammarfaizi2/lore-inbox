Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964866AbWEOKSg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964866AbWEOKSg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 06:18:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932390AbWEOKSg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 06:18:36 -0400
Received: from mx1.redhat.com ([66.187.233.31]:27295 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932387AbWEOKSf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 06:18:35 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060513201341.63590cff.akpm@osdl.org> 
References: <20060513201341.63590cff.akpm@osdl.org>  <20060513033742.GA18598@hellewell.homeip.net> <44655ECD.10404@yahoo.com.au> <afcef88a0605130921k7139da13k1b7232acb29140c1@mail.gmail.com> <44669D12.5050306@yahoo.com.au> 
To: Andrew Morton <akpm@osdl.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, michael.craig.thompson@gmail.com,
       phillip@hellewell.homeip.net, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, viro@ftp.linux.org.uk, mike@halcrow.us,
       mhalcrow@us.ibm.com, mcthomps@us.ibm.com, toml@us.ibm.com,
       yoder1@us.ibm.com, jmorris@namei.org, sct@redhat.com, ezk@cs.sunysb.edu,
       dhowells@redhat.com
Subject: Re: [PATCH 0/13: eCryptfs] eCryptfs Patch Set 
X-Mailer: MH-E 7.92+cvs; nmh 1.1; GNU Emacs 22.0.50.4
Date: Mon, 15 May 2006 11:17:51 +0100
Message-ID: <30035.1147688271@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:

> Nobody is going to include a half-applied filesystem in their .config while
> performing git-bisection, so it can go in in any order.

Apart from those who routinely attempt "make allyesconfig".

David
