Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754520AbWKHLGL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754520AbWKHLGL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 06:06:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754519AbWKHLGK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 06:06:10 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:1474 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1754521AbWKHLGK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 06:06:10 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Bryan O'Sullivan" <bos@serpentine.com>
Subject: Re: 2.6.19-rc5: known regressions
References: <Pine.LNX.4.64.0611071829340.3667@g5.osdl.org>
	<20061108085235.GT4729@stusta.de>
Date: Wed, 08 Nov 2006 04:04:37 -0700
In-Reply-To: <20061108085235.GT4729@stusta.de> (Adrian Bunk's message of "Wed,
	8 Nov 2006 09:52:35 +0100")
Message-ID: <m17iy65hdm.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> writes:

> Subject    : ipath driver MCEs system on load when HT chip present
> References : http://bugzilla.kernel.org/show_bug.cgi?id=7455
> Submitter  : Bryan O'Sullivan <bos@serpentine.com>
> Caused-By  : Eric W. Biederman <ebiederm@xmission.com>
> Handled-By : Bryan O'Sullivan <bos@serpentine.com>
>              Eric W. Biederman <ebiederm@xmission.com>
> Status     : Bryan and Eric are working on fixing the ipath driver

Except for some stupid little issues the fixes are now agreed to.  Just
final code reviews and testing are needed.

Eric
