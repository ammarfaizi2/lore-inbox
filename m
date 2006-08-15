Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030305AbWHOPbO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030305AbWHOPbO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 11:31:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030349AbWHOPbO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 11:31:14 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:50708 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1030305AbWHOPbN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 11:31:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mSF0DXfxlwDmV5wWM4Y2mMm++SMJIe0vBA4go+FkQ6JWPA1ERv8nESTSSH7jWrpROFjGW4Khc81smQPIAI5b1Sh3MAIq2KrBtEzHRhA0NqAF1Z2YnDNnVcyuGoByOX1btL1dYBnjTAZj2NYP3rqhV+Z/LgnR/yBPEN0J+PGx4rQ=
Message-ID: <13e988610608150831u18ed0e85s50fe3a865548a865@mail.gmail.com>
Date: Tue, 15 Aug 2006 17:31:11 +0200
From: "Carsten Otto" <carsten.otto@gmail.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Daily crashes, incorrect RAID behaviour
In-Reply-To: <13e988610608150436y6812f623p9919b2d5b1989427@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <13e988610608150436y6812f623p9919b2d5b1989427@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Okay, after Ralf's message I found this newsgroup post:
http://groups.google.de/group/linux.debian.user/msg/f12dec920523a629?hl=de&

> You should be aware that currently
> Maxtor Maxline III's(7v300F0's) do not work properly due to a firmware
> bug.  The current version shipping is VA111630, an update is available to
> VA111670 which merely reduces the frequency of timeouts that get the drive
> kicked out from the array.

I got a new firmware from Maxtor today. My disks now have firmware
VA111900, before that I had VA111630. Let's see what happens...

PS: Maxtor's hotline guy had no record about firmware related
problems. I'd like to report those (with the two additional
references), but now the hotline has technical difficulties...

Bye,
-- 
Carsten Otto
carsten.otto@gmail.com
www.c-otto.de
