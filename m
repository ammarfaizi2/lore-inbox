Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271584AbRHQUjj>; Fri, 17 Aug 2001 16:39:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271559AbRHQUja>; Fri, 17 Aug 2001 16:39:30 -0400
Received: from WARSL401PIP3.highway.telekom.at ([195.3.96.75]:36165 "HELO
	email02.aon.at") by vger.kernel.org with SMTP id <S271584AbRHQUjX>;
	Fri, 17 Aug 2001 16:39:23 -0400
Content-Type: text/plain; charset=US-ASCII
From: Peter Klotz <peter.klotz@aon.at>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: Error on fs unmount
Date: Fri, 17 Aug 2001 22:42:26 +0200
X-Mailer: KMail [version 1.2]
In-Reply-To: <01081718390800.01143@localhost.localdomain> <5.1.0.14.2.20010817190012.04579580@pop.cus.cam.ac.uk>
In-Reply-To: <5.1.0.14.2.20010817190012.04579580@pop.cus.cam.ac.uk>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <01081722422601.01143@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Peter,
>
>Could you tell me whether on startup (or whenever you mount the NTFS
>volume) it doesn't give a message but saying: "Trying to open system file
>9!" or "Opening system file 9!".

You were right. I found the message you mentioned several times in 
/var/log/messages:
Aug 17 08:16:50 localhost kernel: Trying to open system file 9!   

Thanks a lot for your quick and helpful response.

Bye, Peter.
