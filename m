Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261984AbVCZKhj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261984AbVCZKhj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 05:37:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262026AbVCZKhi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 05:37:38 -0500
Received: from wproxy.gmail.com ([64.233.184.207]:40464 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261984AbVCZKhf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 05:37:35 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=AsGkiqckLIICR40Lab3v8ppWnv0VnBCwInYB9s2C8+2TbNXCUyWtreu473QmtNDeoCpS6/P7dzYB/4k1cwEITNbMq4X/1rkbgyXI6euUHKhzWhHiRJFKF6ecUxjUZh/YM/hHJg3Bgge2Oa9Vv65vgt0Js0RCS3WDgxyVPIDvKz8=
Message-ID: <470aa293050326023710e7b892@mail.gmail.com>
Date: Sat, 26 Mar 2005 10:37:33 +0000
From: Tux <nclarke@gmail.com>
Reply-To: Tux <nclarke@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: forkbombing Linux distributions
In-Reply-To: <e0716e9f05032019064c7b1cec@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <e0716e9f05032019064c7b1cec@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm confused, are hard limits to RLIMIT_NPROC imposed on services
spawned by init before a user logs in?
