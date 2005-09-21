Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964798AbVIUUNN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964798AbVIUUNN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 16:13:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964796AbVIUUNN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 16:13:13 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:43414 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S964798AbVIUUNM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 16:13:12 -0400
Date: Wed, 21 Sep 2005 13:13:04 -0700 (PDT)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Hugh Dickins <hugh@veritas.com>
cc: Frank van Maarseveen <frankvm@frankvm.com>, Jay Lan <jlan@engr.sgi.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.14-rc2] fix incorrect mm->hiwater_vm and mm->hiwater_rss
In-Reply-To: <Pine.LNX.4.61.0509212053050.11309@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.62.0509211310120.11887@schroedinger.engr.sgi.com>
References: <20050921121915.GA14645@janus> <Pine.LNX.4.61.0509211515330.6114@goblin.wat.veritas.com>
 <43319111.1050803@engr.sgi.com> <Pine.LNX.4.61.0509211802150.8880@goblin.wat.veritas.com>
 <4331990A.80904@engr.sgi.com> <Pine.LNX.4.61.0509211835190.9340@goblin.wat.veritas.com>
 <4331A0DA.5030801@engr.sgi.com> <20050921182627.GB17272@janus>
 <Pine.LNX.4.61.0509211958410.10449@goblin.wat.veritas.com>
 <Pine.LNX.4.62.0509211246490.11619@schroedinger.engr.sgi.com>
 <Pine.LNX.4.61.0509212053050.11309@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Sep 2005, Hugh Dickins wrote:

> I don't expect you to disagree with it; but nor do I expect you
> to be anything but disappointed, realizing that's all I meant.

Oh dont worry, this sound good. Otherwise I only expect you to produce the 
vm with the highest performance ever.... ;-)
