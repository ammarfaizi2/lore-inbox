Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130766AbQLKBMz>; Sun, 10 Dec 2000 20:12:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132971AbQLKBMg>; Sun, 10 Dec 2000 20:12:36 -0500
Received: from rmx325-mta.mail.com ([165.251.48.53]:26062 "EHLO
	rmx325-mta.mail.com") by vger.kernel.org with ESMTP
	id <S130766AbQLKBMd>; Sun, 10 Dec 2000 20:12:33 -0500
Message-ID: <390158470.976495326591.JavaMail.root@web346-wra.mail.com>
Date: Sun, 10 Dec 2000 19:42:03 -0500 (EST)
From: Frank Davis <fdavis112@juno.com>
To: linux-kernel@vger.kernel.org
Subject: INIT_LIST_HEAD marco audit
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Mailer: mail.com
X-Originating-IP: 151.201.242.214
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
        It looks like we need to perform an audit of test12-pre8 and find all the changes where INIT_LIST_HEAD should now be used.  Does anyone have a complete list of all the problem drivers, as well as a list of the ones that have already been fixed? If so, please post it to l-k . I don't mind maintaining a list of those patches..Just send them to fdavis112@juno.com .
Regards,
-Frank


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
