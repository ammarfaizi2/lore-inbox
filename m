Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129669AbQL0S4Y>; Wed, 27 Dec 2000 13:56:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129812AbQL0S4N>; Wed, 27 Dec 2000 13:56:13 -0500
Received: from smtp10.atl.mindspring.net ([207.69.200.246]:50748 "EHLO
	smtp10.atl.mindspring.net") by vger.kernel.org with ESMTP
	id <S129669AbQL0S4D>; Wed, 27 Dec 2000 13:56:03 -0500
Message-ID: <3A4A34CD.D753664B@atlanta.com>
Date: Wed, 27 Dec 2000 13:28:29 -0500
From: Raymond Carney <rayc@atlanta.com>
X-Mailer: Mozilla 4.75 [en] (Win98; U)
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: New possibilities for HPT370 RAID support?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've read everything that I can find regarding support of the Highpoint
controllers RAID functionality under Linux, and I understand what the issues
have been. The one promising bit of information that I dug up in this process is
that the 'pseudo' RAID functionality of the Highpoint and Promise IDE RAID
controllers is now supported in FreeBSD (4.2-RELEASE and 5.0-CURRENT). My
question is, can the new BSD code be leveraged to add support for these
controllers to the Linux kernel, and could we reasonably expect to see such
support in the near future?

Please CC: me directly on any replies, and Thanks very much in advance.
-- 
    ______________________________________________________________________ 
/***   ________________________________________________________________   ***\
 Raymond Carney       <> Discovery consists of seeing what everybody 
 rayc@atlanta.com     <> has seen and thinking what nobody has thought. 
 860.774.1939         <>                     - Albert Von Szent-Gyorgyi 
       ________________________________________________________________ 
\***______________________________________________________________________***/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
