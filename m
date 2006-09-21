Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750858AbWIUIzO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750858AbWIUIzO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 04:55:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750973AbWIUIzN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 04:55:13 -0400
Received: from mx00.ext.bfk.de ([217.29.46.125]:7836 "EHLO mx00.ext.bfk.de")
	by vger.kernel.org with ESMTP id S1750858AbWIUIzM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 04:55:12 -0400
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Historic Linux 2.4 GIT repository
References: <82odt9obir.fsf@mid.bfk.de>
	<Pine.LNX.4.61.0609211048560.22923@yvahk01.tjqt.qr>
From: Florian Weimer <fweimer@bfk.de>
Date: Thu, 21 Sep 2006 10:55:10 +0200
In-Reply-To: <Pine.LNX.4.61.0609211048560.22923@yvahk01.tjqt.qr> (Jan Engelhardt's message of "Thu, 21 Sep 2006 10:49:17 +0200 (MEST)")
Message-ID: <82irjhoaz5.fsf@mid.bfk.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jan Engelhardt:

>>Is there a GIT repository with historic data, from the 2.5 branch
>>point until the start of Marcelo's (converted?) repository?  If yes,
>>what's its URL?
>
> I think no, the first GIT shot being 2.6.12, IIRC.

There are several converted repositories.  This one by Thomas Gleixner
covers 2.5.0 till 2.6.12pre-something:

  git://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git

But the changes I'm interested (several dl2k patches) have not bee
applied to this development line.

-- 
Florian Weimer                <fweimer@bfk.de>
BFK edv-consulting GmbH       http://www.bfk.de/
Durlacher Allee 47            tel: +49-721-96201-1
D-76131 Karlsruhe             fax: +49-721-96201-99
