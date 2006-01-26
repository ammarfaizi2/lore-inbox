Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932120AbWAZJp0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932120AbWAZJp0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 04:45:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932181AbWAZJp0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 04:45:26 -0500
Received: from mx1.redhat.com ([66.187.233.31]:58806 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932120AbWAZJpZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 04:45:25 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060125204619.GD12039@hardeman.nu> 
References: <20060125204619.GD12039@hardeman.nu>  <11380489522552@2gen.com> <16978.1138099067@hades.cambridge.redhat.com> 
To: David =?us-ascii?Q?=3D=3Fiso-8859-1=3FQ=3FH=3DE4rdeman=3F=3D?= 
	<david@2gen.com>
Cc: David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/04] Add multi-precision-integer maths library 
X-Mailer: MH-E 7.84; nmh 1.1; GNU Emacs 22.0.50.1
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Date: Thu, 26 Jan 2006 09:45:24 +0000
Message-ID: <19002.1138268724@hades.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Härdeman <david@2gen.com> wrote:

> Somewhat confusing...I downloaded kernel-2.6.15-1.1871_FC5.src.rpm and
> extracted linux-2.6-modsign-mpilib.patch from the srpm. After diffing the mpi
> dirs created by the previously mentioned patch and that from the Fedora kernel
> I get:

That may be the only fix you need. Check the related patches also for overlap.

David
