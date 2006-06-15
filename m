Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932422AbWFODke@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932422AbWFODke (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 23:40:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932424AbWFODke
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 23:40:34 -0400
Received: from wr-out-0506.google.com ([64.233.184.227]:34008 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932422AbWFODkd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 23:40:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=nIgVzkEYr9Dns6mx+sgkRnCbiCmBecfoiSxdkkOGnub89IptGiGV6K38w5Njdok8XPiMG11Ij5d/wjsE9WaDoYIM5HrRCJN9gl0e1IGcPOgLfFn+g6aY9AiGQ0Yg7W61buVJZLbojOuLjL45PS03t7CqAz5xmA9T4/vGG/hGz0o=
Message-ID: <ef5305790606142040r5912ce58kf9f889c3d61b2cc0@mail.gmail.com>
Date: Thu, 15 Jun 2006 15:40:32 +1200
From: "Goo GGooo" <googgooo@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc6-mm2
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> - To fetch an -mm tree using git, use (for example)
>
>  git fetch git://git.kernel.org/pub/scm/linux/kernel/git/smurf/linux-trees.git v2.6.16-rc2-mm1

I'm not able to get -mm tree from GIT. In
http://git.kernel.org/.../smurf/linux-trees.git/refs/tags/ I can see
the most recent tags like v2.6.17-rc6-mm2 but cg-clone
http://git.kernel.org/.../smurf/linux-trees.git gives me only
2.6.16-rc3 :(

I tried "cg-fetch v2.6.17-rc6-mm2" which seemed to fetch some more
tags, then played with git-checkout & friends but still can't get the
most recent source tree.

How do I do that? Best if I could still fetch updates in the same tree later.

RTFM is all right if followed by a link to TFM ;-)

Thanks

Goo
