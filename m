Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129143AbRAZNOO>; Fri, 26 Jan 2001 08:14:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129604AbRAZNOF>; Fri, 26 Jan 2001 08:14:05 -0500
Received: from cable230.225.eneco.bart.nl ([195.38.225.230]:54289 "HELO
	capsi.com") by vger.kernel.org with SMTP id <S129143AbRAZNNw>;
	Fri, 26 Jan 2001 08:13:52 -0500
Date: Fri, 26 Jan 2001 14:13:50 +0100
From: Rob Kaper <cap@capsi.com>
To: linux-kernel@vger.kernel.org
Subject: Renaming lost+found
Message-ID: <20010126141350.Q6979@capsi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Operating-System: Linux ezri 2.2.17 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If this is ext2 specific, just say so and I'll find a better list to discuss
this: (any good ext2 lists available for example?)

Is there a way to rename lost+found ?? It bothers me to see it in ls all the
time because 99.9% of my time it's just useless and I really think
.lost+found (a hidden file) would make much more sense for daily use. I
assume this would require some ext2 changes as well as a patch to e2fsck
etc. (with backwards compatibility of course)

Regards,

Rob
-- 
Rob Kaper | cap@capsi.com cap@capsi.net cap@capsi.co.uk
          | http://capsi.com/ - telnet://chat.capsi.com:2300/
          | 'What? In riddles?' said Gandalf. 'No! For I was talking aloud
          | to myself. A habit of the old: they choose the wisest person
          | present to speak to; the long explanations needed by the young
          | are wearying.' - "Lord of the Rings", JRR Tolkien
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
