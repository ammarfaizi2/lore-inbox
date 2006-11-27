Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757451AbWK0Irb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757451AbWK0Irb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 03:47:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757453AbWK0Irb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 03:47:31 -0500
Received: from il.qumranet.com ([62.219.232.206]:55501 "EHLO cleopatra.q")
	by vger.kernel.org with ESMTP id S1757451AbWK0Ira (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 03:47:30 -0500
Message-ID: <456AA620.4000201@qumranet.com>
Date: Mon, 27 Nov 2006 10:47:28 +0200
From: Avi Kivity <avi@qumranet.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: kvm-devel@lists.sourceforge.net
CC: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH 0/2] KVM: Sync with -mm tree
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Following are a couple of patches I've neglected to send out and are 
thus not in -mm.  One clarifies the KVM license and the other makes enum 
values explicit.

Merging them will sync my current release tree to -mm, which will help 
avoid fuzz in the event we have to merge a large patchset.

-- 
error compiling committee.c: too many arguments to function

