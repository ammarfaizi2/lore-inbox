Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030436AbWAXKh4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030436AbWAXKh4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 05:37:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030440AbWAXKh4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 05:37:56 -0500
Received: from mx1.redhat.com ([66.187.233.31]:56200 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030436AbWAXKh4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 05:37:56 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <11380489522552@2gen.com> 
References: <11380489522552@2gen.com> 
To: David =?us-ascii?Q?=3D=3Fiso-8859-1=3FQ=3FH=3DE4rdeman=3F=3D?= 
	<david@2gen.com>
Cc: linux-kernel@vger.kernel.org, dhowells@redhat.com
Subject: Re: [PATCH 01/04] Add multi-precision-integer maths library 
X-Mailer: MH-E 7.84; nmh 1.1; GNU Emacs 22.0.50.1
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Date: Tue, 24 Jan 2006 10:37:47 +0000
Message-ID: <16978.1138099067@hades.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Härdeman <david@2gen.com> wrote:

> Adds the multi-precision-integer maths library which was originally taken
> from GnuPG and ported to the kernel by David Howells in 2004
> (http://people.redhat.com/~dhowells/modsign/modsign-269rc4mm1-2.diff.bz2)

You should update these files from a latest Fedora, Rawhide or RHEL kernel to
pick up the bug fixes that have been made.

David
