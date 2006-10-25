Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423188AbWJYKSu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423188AbWJYKSu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 06:18:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423190AbWJYKSu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 06:18:50 -0400
Received: from main.gmane.org ([80.91.229.2]:43499 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1423188AbWJYKSu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 06:18:50 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Oleg Verych <olecom@flower.upol.cz>
Subject: Re: [git failure] failure pulling latest Linus tree
Date: Wed, 25 Oct 2006 10:18:22 +0000 (UTC)
Organization: Palacky University in Olomouc, experimental physics department.
Message-ID: <slrnejuert.93p.olecom@flower.upol.cz>
References: <yq0d58g92u0.fsf@jaguar.mkp.net>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: flower.upol.cz
Mail-Followup-To: LKML <linux-kernel@vger.kernel.org>, Oleg Verych <olecom@flower.upol.cz>
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo.

On 2006-10-25, Jes Sorensen wrote:
> This morning I got in and tried to pull the tree from vger, however I
> get the following strange error message:
>
> jes@eye:~/src/kernel/linus/linux-2.6> git pull
> fatal: unexpected EOF
> Fetch failure:
> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
> jes@eye:~/src/kernel/linus/linux-2.6> git --version
> git version 1.4.1.1
>
> Known error? git tree corrupted or need for a new version of git?

Maybe helpful:
<http://permalink.gmane.org/gmane.linux.kernel/456625>
____

