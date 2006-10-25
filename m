Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423146AbWJYJMJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423146AbWJYJMJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 05:12:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423147AbWJYJMJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 05:12:09 -0400
Received: from jaguar.mkp.net ([192.139.46.146]:44167 "EHLO jaguar.mkp.net")
	by vger.kernel.org with ESMTP id S1423146AbWJYJMI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 05:12:08 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: Junio C Hamano <junkio@cox.net>, linux-kernel@vger.kernel.org
Subject: [git failure] failure pulling latest Linus tree
From: Jes Sorensen <jes@sgi.com>
Date: 25 Oct 2006 05:12:07 -0400
Message-ID: <yq0d58g92u0.fsf@jaguar.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This morning I got in and tried to pull the tree from vger, however I
get the following strange error message:

jes@eye:~/src/kernel/linus/linux-2.6> git pull
fatal: unexpected EOF
Fetch failure:
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
jes@eye:~/src/kernel/linus/linux-2.6> git --version
git version 1.4.1.1

Known error? git tree corrupted or need for a new version of git?

Cheers,
Jes
