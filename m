Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279190AbRJWBoq>; Mon, 22 Oct 2001 21:44:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279188AbRJWBog>; Mon, 22 Oct 2001 21:44:36 -0400
Received: from h24-81-34-152.ok.shawcable.net ([24.81.34.152]:29188 "EHLO
	phoenixsoftware.ca") by vger.kernel.org with ESMTP
	id <S279185AbRJWBoZ>; Mon, 22 Oct 2001 21:44:25 -0400
Date: Mon, 22 Oct 2001 18:50:20 -0700
From: BH <bill@phoenixsoftware.ca>
Message-Id: <200110230150.SAA16241@phoenixsoftware.ca>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.13-pre6 breaks Nvidia's kernel module
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The readme for their NVdriver explicitly states "All official stable kernel releases from 2.2.12 and up are supported;
"prerelease" versions such as "2.4.3-pre2" are not supported, nor are
development series kernels such as 2.3.x or 2.5.x."

Appendix B, http://www.nvidia.com/docs/lo/1021/SUPP/README.txt

Run a release kernel with thier driver, let them worry about the changes, since they have the linux source, and the kernel developers do not have thiers.
