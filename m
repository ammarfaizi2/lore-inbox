Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932459AbVIZSZr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932459AbVIZSZr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 14:25:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932460AbVIZSZr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 14:25:47 -0400
Received: from xenotime.net ([66.160.160.81]:47544 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932459AbVIZSZr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 14:25:47 -0400
Date: Mon, 26 Sep 2005 11:25:45 -0700 (PDT)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: Xose Vazquez Perez <xose.vazquez@gmail.com>
cc: Randy Dunlap <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH 2.6.12 1/1] docs: updated some code docs
In-Reply-To: <ee588a5405092611108a9d063@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0509261122220.11898@shark.he.net>
References: <ee588a54050726152014f56899@mail.gmail.com> 
 <16727.134.134.136.2.1122417419.squirrel@chretien.genwebhost.com>
 <ee588a5405092611108a9d063@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Sep 2005, Xose Vazquez Perez wrote:

> ok, here it goes agains somethig called "Affluent Albatross" aka 2.6.14-rc2-git5

All looks good to me except for this one line:

 Andrew Morton's patch scripts:
-http://www.zip.com.au/~akpm/linux/patches/patch-scripts-0.20                   +http://www.zip.com.au/~akpm/linux/patches/
+Instead these ones, people should use quilt ASAP (see above).

Make that last line something like:
Instead of these (tools | scripts), quilt is the recommended
patch management tool (see above).

-- 
~Randy
