Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285484AbRLYMkr>; Tue, 25 Dec 2001 07:40:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285496AbRLYMkh>; Tue, 25 Dec 2001 07:40:37 -0500
Received: from [64.42.30.110] ([64.42.30.110]:29704 "HELO mail.clouddancer.com")
	by vger.kernel.org with SMTP id <S285484AbRLYMke>;
	Tue, 25 Dec 2001 07:40:34 -0500
To: linux-kernel@vger.kernel.org
Message-Id: <20011225124012.BE30C7843A@phoenix.clouddancer.com>
Date: Tue, 25 Dec 2001 04:40:12 -0800 (PST)
From: klink@clouddancer.com (Colonel)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colonel <klink@clouddancer.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.17 missing CONFIG_RTNETLINK ?
Reply-to: klink@clouddancer.com


CONFIG_RTNETLINK provides a means by which the BIRD OSPF routing
daemon communicates with the kernel; in 2.4.16 if I did not enable it,
BIRD did not work....making it difficult to find the next-hop host.

When I went to build 2.4.17 on a dinky box (486, 16M RAM), the config
option was missing.  The box is a wall mount and is not very capable
of multiple kernel experimentation alas.  Can someone supply some
background as to what has happened?

Thanks,
Ron
