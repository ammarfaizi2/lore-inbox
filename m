Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136165AbRECHar>; Thu, 3 May 2001 03:30:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136149AbRECHai>; Thu, 3 May 2001 03:30:38 -0400
Received: from mailout02.sul.t-online.com ([194.25.134.17]:36873 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S136159AbRECHaa>; Thu, 3 May 2001 03:30:30 -0400
Date: 03 May 2001 09:32:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: jlundell@pobox.com
cc: linux-kernel@vger.kernel.org
Message-ID: <80BTbI6mw-B@khms.westfalen.de>
In-Reply-To: <p05100303b70eadd613b0@[207.213.214.37]>
Subject: Re: [PATCH] adding PCI bus information to SCSI layer
X-Mailer: CrossPoint v3.12d.kh6 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <p05100303b70eadd613b0@[207.213.214.37]>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jlundell@pobox.com (Jonathan Lundell)  wrote on 26.04.01 in <p05100303b70eadd613b0@[207.213.214.37]>:

> At 10:31 PM -0600 2001-04-26, Richard Gooch wrote:
> >BTW: please fix your mailer to do linewrap at 72 characters. Your
> >lines are hundreds of characters long, and that's hard to read.
>
> Sorry for the inconvenience. There are a lot of reasons why I believe
> it's properly a display function to wrap long lines, and that an MUA
> has no business altering outgoing messages (one on-topic reason being
> that patches get screwed up by inserted newlines), but I grant that
> there are broken clients out there that can't or won't or don't wrap
> at display time.

What's a lot more important is that the mail standards say that this stuff  
should not be interpreted by the receivers as needing wrapping, so  
irregardless of good or bad design it's just plain illegal.

If you want to support wrapping with plain text, investigate  
format=flowed.

MfG Kai
