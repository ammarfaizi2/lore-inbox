Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135472AbRAQSeD>; Wed, 17 Jan 2001 13:34:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135489AbRAQSdx>; Wed, 17 Jan 2001 13:33:53 -0500
Received: from p3EE0E4A2.dip.t-dialin.net ([62.224.228.162]:22032 "EHLO
	router.abc") by vger.kernel.org with ESMTP id <S135472AbRAQSdf>;
	Wed, 17 Jan 2001 13:33:35 -0500
Message-ID: <3A65E573.D004302B@baldauf.org>
Date: Wed, 17 Jan 2001 19:33:23 +0100
From: Xuan Baldauf <xuan--lkml@baldauf.org>
Organization: Medium.net
X-Mailer: Mozilla 4.76 [en] (Win98; U)
X-Accept-Language: de-DE,en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Relative CPU time limit
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, (maybe a FAQ, but could not find this question)

is it possible with linux2.4 to limit the relative CPU time
per process or per UID? I saw something like this about 5
years ago on solaris machines, but I have not access to
solaris machines anymore. I do not mean limiting the
absolute CPU time (e.g. "the process should run 20minutes at
maximum and shall be killed after that time), but the
relative CPU time (e.g. "apache should consume at most 80%
of my servers CPU time and shall be throttled if it was to
consume more").

Thanx,
Xuân. :-)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
