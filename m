Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132203AbRAOFVg>; Mon, 15 Jan 2001 00:21:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132261AbRAOFVT>; Mon, 15 Jan 2001 00:21:19 -0500
Received: from smtp-rt-12.wanadoo.fr ([193.252.19.60]:61905 "EHLO
	tamaris.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S132203AbRAOFU7>; Mon, 15 Jan 2001 00:20:59 -0500
Message-ID: <3A628870.EA2C3BF9@wanadoo.fr>
Date: Mon, 15 Jan 2001 06:19:44 +0100
From: Pierre Rousselet <pierre.rousselet@wanadoo.fr>
Organization: Home PC
X-Mailer: Mozilla 4.76 [fr] (X11; U; Linux 2.4.0-ac9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.0-x features ?
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pentium-III 256Mb BE6.
1) top (procps-2.0.7) gives me the messages :
'bad data in /proc/uptime'
'bad data in /proc/loadavg'
cat /proc/uptime 
1435.30 904.74
cat /proc/loadavg
0.01 0.21 0.29 1/17 19444
What is wrong ?
2) pppd (2.4.0b4) gives me the message :
'tdb_store failed : Success'
'tdb_store key failed : Success'
What does that mean ?
-- 
------------------------------------------------
 Pierre Rousselet <pierre.rousselet@wanadoo.fr>
------------------------------------------------
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
