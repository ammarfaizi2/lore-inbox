Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753442AbWKGVlK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753442AbWKGVlK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 16:41:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753447AbWKGVlK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 16:41:10 -0500
Received: from mx.pathscale.com ([64.160.42.68]:40912 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1753442AbWKGVlJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 16:41:09 -0500
Date: Tue, 7 Nov 2006 13:41:08 -0800 (PST)
From: Dave Olson <olson@pathscale.com>
Reply-To: olson@pathscale.com
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "Bryan O'Sullivan" <bos@serpentine.com>, Adrian Bunk <bunk@stusta.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.19-rc4: known unfixed regressions (v3)
In-Reply-To: <m1hcxb7xes.fsf@ebiederm.dsl.xmission.com>
Message-ID: <Pine.LNX.4.64.0611071339410.8122@topaz.pathscale.com>
References: <Pine.LNX.4.64.0610302019560.25218@g5.osdl.org>
 <20061105064801.GV13381@stusta.de> <m1lkmpq5we.fsf@ebiederm.dsl.xmission.com>
 <20061107042214.GC8099@stusta.de> <45501730.8020802@serpentine.com>
 <m1psbzbpxw.fsf@ebiederm.dsl.xmission.com> <4550B22C.1060307@serpentine.com>
 <m18xinb1qn.fsf@ebiederm.dsl.xmission.com> <Pine.LNX.4.64.0611070934570.25925@topaz.pathscale.com>
 <m1mz739l0b.fsf@ebiederm.dsl.xmission.com> <Pine.LNX.4.64.0611071228230.8122@topaz.pathscale.com>
 <m1wt677zgr.fsf@ebiederm.dsl.xmission.com> <Pine.LNX.4.64.0611071258220.8122@topaz.pathscale.com>
 <m1hcxb7xes.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Nov 2006, Eric W. Biederman wrote:
| I think we are talking past each other.  I think it is fine but silly
| to set a standard register that isn't actually used.  It probably makes
| debugging a little easier but it might also make things a little more
| confusing because we are doing something totally unnecessary.

I think we are saying exactly the same thing, so I'll leave it at that.

Dave Olson
dave.olson@qlogic.com
