Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S154444AbPG1Gfq>; Wed, 28 Jul 1999 02:35:46 -0400
Received: by vger.rutgers.edu id <S154382AbPG1Gf0>; Wed, 28 Jul 1999 02:35:26 -0400
Received: from relayd.gateway.net ([208.230.117.252]:3397 "EHLO smtp8.gateway.net") by vger.rutgers.edu with ESMTP id <S154419AbPG1GfL>; Wed, 28 Jul 1999 02:35:11 -0400
Message-ID: <379EA540.CE869EC2@gateway.net>
Date: Tue, 27 Jul 1999 23:37:52 -0700
From: merblich <merblich@gateway.net>
X-Mailer: Mozilla 4.06 [en]C-gatewaynet  (Win98; I)
MIME-Version: 1.0
To: linux-kernel@vger.rutgers.edu
Subject: [RFC] - skiplists and link lists
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-kernel@vger.rutgers.edu

Group,

	At: http://www.medsp.com/scott/alg/node35.html

	has a implimentation and description of skip lists.

	On lists that can grow beyond a specific number of
	elements, I believe that the lists should then be
	converted to skip lists.

	I am slowly working on a generic implimentation of
	the above. Maybe by Sept timeframe...

	Comments .....

	Mitchell Erblich

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
