Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932233AbVIYPui@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932233AbVIYPui (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Sep 2005 11:50:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932229AbVIYPuh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Sep 2005 11:50:37 -0400
Received: from smtp-out2.blueyonder.co.uk ([195.188.213.5]:47758 "EHLO
	smtp-out2.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S932232AbVIYPuh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Sep 2005 11:50:37 -0400
Message-ID: <4336C6D8.4090602@blueyonder.co.uk>
Date: Sun, 25 Sep 2005 16:48:40 +0100
From: Sid Boyce <sboyce@blueyonder.co.uk>
Reply-To: sboyce@blueyonder.co.uk
Organization: blueyonder.co.uk
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] ktimers subsystem
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 Sep 2005 15:49:29.0601 (UTC) FILETIME=[B6F4FF10:01C5C1E8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OT, but something that's been bugging me for quite a while.
I cut and paste the patch from the email to a file ktimers.patch.
"# patch -l -p1 <ktimer.patch" and it returns ---
  (Patch is indented 1 space.)
patching file fs/exec.c
patch: **** malformed patch at line 16: }

If I prepend 2 tabs to the line, it complains about line 17, I do the 
same to line 17 and on it moves to the next. from the manpage it reads 
like the "-l" should take care of the tabs so it only compares the text.
Can anyone suggest how to apply the patch? Googling didn't help.
Regards
Sid.
-- 
Sid Boyce ... Hamradio License G3VBV, licensed Private Pilot
Retired IBM/Amdahl Mainframes and Sun/Fujitsu Servers Tech Support 
Specialist
Microsoft Windows Free Zone - Linux used for all Computing Tasks
