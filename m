Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311291AbSCLR3a>; Tue, 12 Mar 2002 12:29:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311310AbSCLR3U>; Tue, 12 Mar 2002 12:29:20 -0500
Received: from [66.35.146.201] ([66.35.146.201]:14866 "EHLO int1.nea-fast.com")
	by vger.kernel.org with ESMTP id <S311301AbSCLR3O>;
	Tue, 12 Mar 2002 12:29:14 -0500
Message-Id: <200203121729.MAA08522@int1.nea-fast.com>
Content-Type: text/plain; charset=US-ASCII
From: walter <walt@nea-fast.com>
To: linux-kernel@vger.kernel.org
Subject: oracle rmap kernel version
Date: Tue, 12 Mar 2002 12:29:29 -0500
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Does anyone have any production experience running Oracle 8i on Linux? I've 
run it at home, RH 7.2 with vanilla 2.4.16 kernel all IDE drives, and its 
fast. We are replacing our SUN/Oracle 8 servers at work in next couple of 
months with Linux/Oracle 8i (Pentium 4 1GB ram).  My question is, what is the 
best kernel version to use,  vanilla 2.4.x or a RH kernel built from the ac 
tree with rmap. All drives will be SCSI. 
I read an interview yesterday with Rik van Riel where he said rmap worked 
better for db servers but I expect that he is partial to rmap 8-).
Our web servers are running vanilla 2.4.16 and we haven't had a problem yet 
(knock on wood).

Thanks !
-- 
Walter Anthony
System Administrator
National Electronic Attachment
"If it's not broke....tweak it"
