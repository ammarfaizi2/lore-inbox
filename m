Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262487AbREULdo>; Mon, 21 May 2001 07:33:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262488AbREULde>; Mon, 21 May 2001 07:33:34 -0400
Received: from samar.sasken.com ([164.164.56.2]:26855 "EHLO samar.sasken.com")
	by vger.kernel.org with ESMTP id <S262487AbREULd3>;
	Mon, 21 May 2001 07:33:29 -0400
To: linux-kernel@vger.kernel.org
X-News-Gateway: ncc-b.sasi.com
From: Deepika Kakrania <deepika@sasken.com>
Subject: use of CBQ for output queue...
Date: Mon, 21 May 2001 15:53:58 +0530
Message-ID: <Pine.GSO.4.30.0105211548590.15186-100000@sunk3.sasi.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Trace: ncc-c.sasi.com 990440638 24823 10.0.80.3 (21 May 2001 10:23:58 GMT)
X-Complaints-To: usenet@sasi.com
Xref: ncc-b.sasi.com maillist.linux-kernel:152755
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 Hi,

  I want to use CBQ for device output queue. there is tc(user space
) program which can be used to set queueing discipline, classes and
filter rules. But I want to do it within kernel.

 Can anyone tell me how do I set these rules from kernel itself?

Thanks in advance.

regards,
Deepika


