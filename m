Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932091AbVKJVUs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932091AbVKJVUs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 16:20:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932090AbVKJVUr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 16:20:47 -0500
Received: from [212.76.80.249] ([212.76.80.249]:45836 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S932088AbVKJVUr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 16:20:47 -0500
From: Al Boldi <a1426z@gawab.com>
To: linux-net@vger.kernel.org
Subject: TCP connection striping
Date: Fri, 11 Nov 2005 00:17:26 +0300
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200511110017.26815.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


TCP connections are inherently throttled. (see 'TCP throttling' thread)

Although redesigning the TCP stack from scratch, to circumvent this and other 
quirks, is probably to much to ask for, would striping the connection, over 
i.e. a tunnel, be a reasonable workaround?

Thanks!

--
Al
