Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262204AbREQWmO>; Thu, 17 May 2001 18:42:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262200AbREQWmF>; Thu, 17 May 2001 18:42:05 -0400
Received: from mailout00.sul.t-online.com ([194.25.134.16]:59404 "EHLO
	mailout00.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S262199AbREQWlw>; Thu, 17 May 2001 18:41:52 -0400
Date: 17 May 2001 22:40:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <811ooI$Hw-B@khms.westfalen.de>
In-Reply-To: <20010515154325.Z5599@sventech.com>
Subject: Re: LANANA: To Pending Device Number Registrants
X-Mailer: CrossPoint v3.12d.kh6 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <Pine.LNX.4.21.0105151208540.2339-100000@penguin.transmeta.com> <20010515145830.Y5599@sventech.com> <Pine.LNX.4.21.0105151208540.2339-100000@penguin.transmeta.com> <20010515154325.Z5599@sventech.com>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

johannes@erdfelt.com (Johannes Erdfelt)  wrote on 15.05.01 in <20010515154325.Z5599@sventech.com>:

> I had always made the assumption that sockets were created because you
> couldn't easily map IPv4 semantics onto filesystems. It's unreasonable
> to have a file for every possible IP address/port you can communicate
> with.

Not at all. What is unreasonable is douing a "ls" on the directory in  
question.

Big deal; make it mode d--x--x--x. Problem solved.

And I'm pretty certain stuff like that *has* been done - wasn't there a  
ftp file system where you could "ls /mountpoint/ftp.kernel.org/pub/linux"?

MfG Kai
