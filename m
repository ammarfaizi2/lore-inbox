Return-Path: <linux-kernel-owner+w=401wt.eu-S1161353AbWLPSo6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161353AbWLPSo6 (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 13:44:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161356AbWLPSo5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 13:44:57 -0500
Received: from sorrow.cyrius.com ([65.19.161.204]:36874 "EHLO
	sorrow.cyrius.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161353AbWLPSo5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 13:44:57 -0500
Date: Sat, 16 Dec 2006 19:44:50 +0100
From: Martin Michlmayr <tbm@cyrius.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, debian-kernel@lists.debian.org
Subject: Re: Recent mm changes leading to filesystem corruption?
Message-ID: <20061216184450.GA21129@deprecation.cyrius.com>
References: <20061216155044.GA14681@deprecation.cyrius.com> <Pine.LNX.4.64.0612161812090.21270@blonde.wat.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612161812090.21270@blonde.wat.veritas.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Hugh Dickins <hugh@veritas.com> [2006-12-16 18:20]:
> Very disturbing.  I'm not aware of any problem with them, and we
> surely wouldn't have released 2.6.19 with any known-corrupting patches
> in.  There's some doubts about 2.6.19 itself in the links below: were
> it not for those, I'd suspect a mismerge of the pieces into 2.6.18,
> perhaps a hidden dependency on something else.  I'll ponder a little,
> but let's CC linux-mm in case someone there has an idea.

Do you think http://article.gmane.org/gmane.linux.kernel/473710 might
be related?
-- 
Martin Michlmayr
http://www.cyrius.com/
