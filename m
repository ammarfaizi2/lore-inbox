Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129853AbQK1IQW>; Tue, 28 Nov 2000 03:16:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130191AbQK1IQM>; Tue, 28 Nov 2000 03:16:12 -0500
Received: from [195.65.218.116] ([195.65.218.116]:26002 "EHLO
        uxmailstest.stest.ch") by vger.kernel.org with ESMTP
        id <S129853AbQK1IPz>; Tue, 28 Nov 2000 03:15:55 -0500
Message-ID: <3A2363C2.BA966C18@pop.agri.ch>
Date: Tue, 28 Nov 2000 08:50:36 +0100
From: Andreas Tobler <toa@pop.agri.ch>
Reply-To: toa@pop.agri.ch
Organization: zero
X-Mailer: Mozilla 4.75 (Macintosh; U; PPC)
X-Accept-Language: en
MIME-Version: 1.0
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: proc_fs Howto for 2.2.X?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Is there a paper around which describes the use of the proc_fs in the
actual 2.2.17 and up kernels? All I have is the Rubini book which is a
bit aged regarding the proc_fs, and this guide:
http://www.ibiblio.org/mdw/LDP/lkmpg/mpg.html. Also a bit dated.

Exactly what I'm looking for is an explanation whether I should use
proc_register/unregister or create_proc_entry/remove_proc_entry. 
I know source is the best teacher, but having a look into 2.2.17 I find
tons of proc_register/unregister references. 
To solve my problem I had to use create_proc_entry / remove_proc_entry.
Now I'm not sure if this is the right approach for 2.2.17 and up?

If this was discussed already, sorry, a link to the discussion would be
great. 

Thanks for any hint, pointer....

Andreas
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
