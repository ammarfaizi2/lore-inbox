Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281504AbSAARGR>; Tue, 1 Jan 2002 12:06:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280725AbSAARGH>; Tue, 1 Jan 2002 12:06:07 -0500
Received: from mailout05.sul.t-online.com ([194.25.134.82]:55732 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S281504AbSAARFx>; Tue, 1 Jan 2002 12:05:53 -0500
Date: 01 Jan 2002 13:50:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: Andries.Brouwer@cwi.nl
cc: linux-kernel@vger.kernel.org
Message-ID: <8G3WBQdHw-B@khms.westfalen.de>
In-Reply-To: <UTC200112311529.PAA122887.aeb@cwi.nl>
Subject: Re: Why would a valid DVD show zero files on Linux?
X-Mailer: CrossPoint v3.12d.kh8 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <UTC200112311529.PAA122887.aeb@cwi.nl>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl  wrote on 31.12.01 in <UTC200112311529.PAA122887.aeb@cwi.nl>:

> Vitaly Lipatov:
>
> > On my system it do not work. :(
>
> So, if either mount is broken or its documentation
> is outdated, why not write to the maintainer (aeb@cwi.nl)
> and tell what is wrong? Empty complaints are useless.

Well, it seems to me that the behaviour described matches the description:  
the list mount claims to try *first*, before looking at user-supplied  
filesystem lists, includes iso9660 but not UDF. So ...

MfG Kai
