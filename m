Return-Path: <linux-kernel-owner+w=401wt.eu-S1750808AbWLNO54@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750808AbWLNO54 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 09:57:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750839AbWLNO54
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 09:57:56 -0500
Received: from main.gmane.org ([80.91.229.2]:53905 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750808AbWLNO5z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 09:57:55 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Manuel Reimer <Manuel.Spam@nurfuerspam.de>
Subject: Will there be security updates for 2.6.17 kernels?
Date: Thu, 14 Dec 2006 15:59:54 +0100
Message-ID: <elrop2$vdl$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd9e4389e.dip0.t-ipconnect.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.8.0.8) Gecko/20061108 SeaMonkey/1.0.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

my problem is, that the slackware maintainers decided to use kernel 
2.6.17. Here is their comment, they posted to the changelog:

After much thought and consultation with developers, it has been decided 
to move 2.6.17.x out of /testing and into /extra.  It runs stable by all 
reports, has better wireless support, and is not going to be stale as 
soon.  In addition, HIGHMEM4G has been enabled.  This caused no problems 
with my old 486 with 24MB (the one I use for compiling KDE ;-), and 
Tomas Matejicek has enabled this in SLAX for a long time with no reports 
of problems, so I believe it is a safe option (and is needed by many 
modern machines). Thanks again to Andrea for building these kernels and 
packages.  :-)

They had a 2.6.16 kernel in /extra before and as far as I know the
2.6.16 kernel series still gets security updates.

Is this also the case for 2.6.17 kernels? will there be an update if
there is an security hole in the latest 2.6.17 kernel?

The problem is, that the slackware team doesn't patch anything on their
own. They always wait for the update done by the author, if the bug
isn't very critical. This means they will stay forever with their
current version of the 2.6.17 kernel, if there will be no updates in
future.

If there will be no updates for 2.6.17 in future: Are there already
security holes in 2.6.17? Could someone please give two examples? I need
informations, to be able to contact the slackware team, to request a
"downgrade" to 2.6.16.

Thank you very much in advance

Yours

Manuel Reimer

