Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030414AbWBHRxp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030414AbWBHRxp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 12:53:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030432AbWBHRxo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 12:53:44 -0500
Received: from hierophant.serpentine.com ([66.92.13.71]:23698 "EHLO
	demesne.serpentine.com") by vger.kernel.org with ESMTP
	id S1030414AbWBHRxo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 12:53:44 -0500
Subject: Re: How in tarnation do I git v2.6.16-rc2?  hg died and I still
	don't git git
From: "Bryan O'Sullivan" <bos@serpentine.com>
To: Paul Jackson <pj@sgi.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060208070301.1162e8c3.pj@sgi.com>
References: <20060208070301.1162e8c3.pj@sgi.com>
Content-Type: text/plain
Date: Wed, 08 Feb 2006 09:53:42 -0800
Message-Id: <1139421223.28484.22.camel@camp4.serpentine.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-02-08 at 07:03 -0800, Paul Jackson wrote:

> I had been using hg (mercurial) to keep a current copy of Linus's
> tree, and to make hg clones at each 2.6.*-rc*, to which I would apply
> Andrew's various 2.6.*-rc*-mm*.
> 
> But the hg tree seems to have died on me, and I still don't git git.

Using Mercurial, pull from here instead:

hg pull http://master.kernel.org/hg/linux-2.6

