Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965196AbWECNNU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965196AbWECNNU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 09:13:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965195AbWECNNU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 09:13:20 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:44697 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S965193AbWECNNT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 09:13:19 -0400
Date: Wed, 3 May 2006 09:13:16 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Yogesh Pahilwan <pahilwan.yogesh@spsoftindia.com>
cc: linux-kernel@vger.kernel.org
Subject: RE: Problem while applying patch to 2.6.9 kernel
In-Reply-To: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAvCUMqSY6jkeq1rIyy7sZ1cKAAAAQAAAA/RwgNB/GzEaFbUDhx3/9tAEAAAAA@spsoftindia.com>
Message-ID: <Pine.LNX.4.58.0605030911460.25288@gandalf.stny.rr.com>
References: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAvCUMqSY6jkeq1rIyy7sZ1cKAAAAQAAAA/RwgNB/GzEaFbUDhx3/9tAEAAAAA@spsoftindia.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 3 May 2006, Yogesh Pahilwan wrote:

> Hi Steven,
>
> I tried specifying -p2 as follows:
>
> # patch -p2 < ../../Patches/patch-ext3
>
> But still getting the same error.
>
> Please suggest.
>

Is this patch proprietary or can you post it?  At least can you show the
parts of the patch that have the diff headers (+++ and ---).

-- Steve

