Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262692AbVFWVdz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262692AbVFWVdz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 17:33:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262830AbVFWV3k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 17:29:40 -0400
Received: from smtp-out6.blueyonder.co.uk ([195.188.213.9]:61850 "EHLO
	smtp-out6.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S262761AbVFWV0V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 17:26:21 -0400
Message-ID: <42BB28FB.1010907@blueyonder.co.uk>
Date: Thu, 23 Jun 2005 22:26:19 +0100
From: Sid Boyce <sboyce@blueyonder.co.uk>
Reply-To: sboyce@blueyonder.co.uk
Organization: blueyonder.co.uk
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: RE: Problem compiling 2.6.12
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 Jun 2005 21:26:58.0045 (UTC) FILETIME=[4923DAD0:01C5783A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is /usr/src/linux a symlink to linux-2.6.12 .... "ls -ld linux" shows that.
"which gcc" would tell if /usr/local/bin/gcc is being used.
"gcc -v" to show the version.
Something looks confused, the above would be helpful.
Regards
Sid.
-- 
Sid Boyce ... Hamradio License G3VBV, Keen licensed Private Pilot
Retired IBM Mainframes and Sun Servers Tech Support Specialist
Microsoft Windows Free Zone - Linux used for all Computing Tasks
