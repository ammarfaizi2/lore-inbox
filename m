Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965656AbVKHCfu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965656AbVKHCfu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 21:35:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965668AbVKHCfu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 21:35:50 -0500
Received: from nproxy.gmail.com ([64.233.182.206]:8061 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965656AbVKHCft convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 21:35:49 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=A5tDQkENN8AwwWyCrqlZbpln8IOYha+OSEUx5/tegO5L96yeHjTM9dCRwM9NGZrdOk2bZsw1VHdGpFWaFeskBceRcNq0fMn8dMMsGqtXHYT6xMj4+r8GqvFmQ4PcKrWqOz1b3JXOv6pdKydb0ouldmTWpUieXSsNJBeiPLF7MKI=
Message-ID: <2cd57c900511071835le734f8do@mail.gmail.com>
Date: Tue, 8 Nov 2005 10:35:48 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: keep in sync with -mm tree?
Cc: linux <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

We can always keep in sync with the current Linus tree through his git
tree. But from where can we keep in sync with the current -mm tree?
ie, when somethings added to -mm, how do we get that too?

The only way now seems to check the mm-commits list. Is it possible to
expose akpm's working folder somewhere for convenience?
--
Coywolf Qi Hunt
http://sosdg.org/~coywolf/
