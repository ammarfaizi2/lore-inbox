Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132007AbRCVNQh>; Thu, 22 Mar 2001 08:16:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132017AbRCVNQ2>; Thu, 22 Mar 2001 08:16:28 -0500
Received: from adglinux1.hns.com ([139.85.108.152]:58315 "EHLO
	adglinux1.hns.com") by vger.kernel.org with ESMTP
	id <S132007AbRCVNQQ>; Thu, 22 Mar 2001 08:16:16 -0500
To: linux-kernel@vger.kernel.org
Subject: regression testing
Content-Type: text/plain; charset=US-ASCII
From: nbecker@fred.net
Date: 22 Mar 2001 08:15:31 -0500
Message-ID: <x88zoeeeyh8.fsf@adglinux1.hns.com>
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.  I was wondering if there has been any discussion of kernel
regression testing.  Wouldn't it be great if we didn't have to depend
on human testers to verify every change didn't break something?

OK, I'll admit I haven't given this a lot of thought.  What I'm
wondering is whether the user-mode linux could help here (allow a way
to simulate controlled activity).
