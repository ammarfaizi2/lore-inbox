Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262401AbVBBQP6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262401AbVBBQP6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 11:15:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262719AbVBBQM4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 11:12:56 -0500
Received: from mproxy.gmail.com ([216.239.56.246]:5435 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261317AbVBBQCu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 11:02:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=HFIwZrmas/9+E3+5vWv8rlNxFl+VW6o8fH+qb5rhGAx+TTxm/8XjPw02MMG7YnC9d6TJ5j1mdCHWDy1s+nOBQy3pQUxhHI8l/9w84PnR2Cjn+2MPhc2M9GFa2upgCz3GL/Dqf+mdf1V8ZnIj2y72v09GXPt2Uq45acFWNvV5oLA=
Message-ID: <dff3752705020208024b5992@mail.gmail.com>
Date: Wed, 2 Feb 2005 11:02:49 -0500
From: Kristina Clair <kclair@gmail.com>
Reply-To: Kristina Clair <kclair@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: dm_snapshot experimental? potential repercussions?
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have been told that dm_snapshot is still experimental in the 2.6.10
kernel, and I was advised not to have more than one snapshot created
at a time for the same logical volume.

Basically I am just wondering what the potential problems are with
dm_snapshot.  Is there anything particular that I should look out for?

Thanks for any advice,
Kristina
