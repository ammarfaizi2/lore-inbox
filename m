Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136235AbRAZBWH>; Thu, 25 Jan 2001 20:22:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136238AbRAZBV5>; Thu, 25 Jan 2001 20:21:57 -0500
Received: from quechua.inka.de ([212.227.14.2]:14418 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S136235AbRAZBVq>;
	Thu, 25 Jan 2001 20:21:46 -0500
From: Bernd Eckenfels <inka-user@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.2.19pre6/7: why can't I dump core?
Message-Id: <E14LxaE-0003pY-00@sites.inka.de>
Date: Fri, 26 Jan 2001 02:21:46 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200101252341.SAA01008@ninigret.metatel.office> you wrote:
> I've done a quick inspection of pre7 patch set and noticed about the
> same thing.  Is this an oversight, did someone intentionally turn off
> core dumping until some other widget is incorporated into the patches,
> or none of the above (a conspiracy, maybe? 8-).

what is ulimit -c telling you?

Greetings
Bernd
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
