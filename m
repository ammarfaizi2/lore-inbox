Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289166AbSAGKYt>; Mon, 7 Jan 2002 05:24:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289167AbSAGKYj>; Mon, 7 Jan 2002 05:24:39 -0500
Received: from smtp.tele.fi ([192.89.123.25]:8290 "EHLO smtp.tele.fi")
	by vger.kernel.org with ESMTP id <S289166AbSAGKYZ>;
	Mon, 7 Jan 2002 05:24:25 -0500
Date: Mon, 7 Jan 2002 14:22:58 +0200 (EET)
From: Philippe Trottier <tchiwam@invers.fi>
To: linux-kernel@vger.kernel.org
Subject: 2.5 suggestion 
Message-ID: <Pine.LNX.4.43.0201071317340.8864-100000@tchiwam2.invers.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

To prevent big confusion after adding or removing hardware (IDE, SCSI,
Network) would it be possible to assign them an order of detection or
give them a fixed Major / minor ?

so that /dev/sd? always refer to the same physical device...

Philippe Trottier

