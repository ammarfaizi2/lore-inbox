Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265873AbUAWSPG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 13:15:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266626AbUAWSPG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 13:15:06 -0500
Received: from lgsx13.lg.ehu.es ([158.227.2.28]:36007 "EHLO lgsx13.lg.ehu.es")
	by vger.kernel.org with ESMTP id S266601AbUAWSNb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 13:13:31 -0500
Message-ID: <40117620.6040103@wanadoo.es>
Date: Fri, 23 Jan 2004 20:29:36 +0100
From: =?ISO-8859-1?Q?Luis_Miguel_Garc=EDa?= <ktech@wanadoo.es>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031206 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: DATA CORRUPTION in 2.6.1 and 2.6.2-rc1 (not in 2.6.0-mm2)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

(sorry with my _very_ poor english)

I've been using 2.6.0-mm2 since it appears with almost no problems 
(besides bttv not giving me audio out).

When I switched to 2.6.1 for the first time, I have just booted and a 
lookup blocked my computer. When I have hand-reseted it, I realized that 
some files was filled with garbage. In fact, modules.autoload was in 
this way.

Because of this, I reverted to 2.6.0-mm2 and newly no problems in a while.

Today, I have builded 2.6.2-rc1 and the same has happened. A hard lookup 
and lots of files were screwed from my /home directory. Xfce has no 
configuration files and Firebird says "Welcome, new Firebird user", so 
lots of files are deleted or filled with garbage.

I have an n-force2 ide chipset running an AMD 2500+ cpu. Do you need 
more info about my hardware?

I have realized that when the lookup ocurrs, the HD led is on all the time.

Thanks a lot.
