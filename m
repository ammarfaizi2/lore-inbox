Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750998AbWGGKeN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750998AbWGGKeN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 06:34:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750997AbWGGKeN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 06:34:13 -0400
Received: from mx1.redhat.com ([66.187.233.31]:38847 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750998AbWGGKeN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 06:34:13 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060707032038.efb71d9d.akpm@osdl.org> 
References: <20060707032038.efb71d9d.akpm@osdl.org>  <20060706105223.97b9a531.akpm@osdl.org> <20060706124716.7098.5752.stgit@warthog.cambridge.redhat.com> <20060706124727.7098.44363.stgit@warthog.cambridge.redhat.com> <20538.1152266076@warthog.cambridge.redhat.com> 
To: Andrew Morton <akpm@osdl.org>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org,
       bernds_cb1@t-online.de, sam@ravnborg.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] FDPIC: Add coredump capability for the ELF-FDPIC binfmt [try #3] 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Fri, 07 Jul 2006 11:34:02 +0100
Message-ID: <32747.1152268442@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:

> I count 45 different implementations of this in the tree.  Ho hum.

The roundup() macro could just be moved in as well.

David
