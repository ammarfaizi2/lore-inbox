Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262215AbTCWB6x>; Sat, 22 Mar 2003 20:58:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262224AbTCWB6w>; Sat, 22 Mar 2003 20:58:52 -0500
Received: from holomorphy.com ([66.224.33.161]:55701 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S262215AbTCWB6w>;
	Sat, 22 Mar 2003 20:58:52 -0500
Date: Sat, 22 Mar 2003 18:09:19 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Manfred Spraul <manfred@colorfullife.com>, zwane@holomorphy.com,
       linux-kernel@vger.kernel.org, jochen@jochen.org
Subject: Re: BUG: Use after free in detach_pid
Message-ID: <20030323020919.GH1350@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@digeo.com>,
	Manfred Spraul <manfred@colorfullife.com>, zwane@holomorphy.com,
	linux-kernel@vger.kernel.org, jochen@jochen.org
References: <Pine.LNX.4.50.0303221152460.18911-100000@montezuma.mastecende.com> <3E7CC4F2.8000500@colorfullife.com> <20030322124447.59c6b4c3.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030322124447.59c6b4c3.akpm@digeo.com>
User-Agent: Mutt/1.3.28i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 22, 2003 at 12:44:47PM -0800, Andrew Morton wrote:
> And that was a uniprocessor without pgcl gunk.

I'd rather not hide my WIP's until they're "perfect".


-- wli
