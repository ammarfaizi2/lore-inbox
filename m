Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129573AbRAIE05>; Mon, 8 Jan 2001 23:26:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129562AbRAIE0r>; Mon, 8 Jan 2001 23:26:47 -0500
Received: from linuxjedi.org ([192.234.5.42]:3346 "EHLO linuxjedi.org")
	by vger.kernel.org with ESMTP id <S129573AbRAIE0d>;
	Mon, 8 Jan 2001 23:26:33 -0500
Message-ID: <3A5A9444.5B2772F2@linuxjedi.org>
Date: Mon, 08 Jan 2001 23:32:04 -0500
From: "David L. Parsley" <parsley@linuxjedi.org>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-ac2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: question on generating a patch
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I read the FAQ and SubmittingPatches, but how best to generate a patch
that moves a file from on dir to another?  diff -urNP makes the patch a
lot longer than it seems like it should be... (fortunately it's just a
short header file)

Is there a better way?

regards,
	David
-- 
David L. Parsley
Network Administrator
Roanoke College
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
