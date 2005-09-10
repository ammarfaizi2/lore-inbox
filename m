Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750738AbVIJKJI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750738AbVIJKJI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 06:09:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750736AbVIJKJI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 06:09:08 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:47753 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750738AbVIJKJG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 06:09:06 -0400
Subject: Re: [WATCHDOG] v2.6.13 watchdog-patches
From: Arjan van de Ven <arjan@infradead.org>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Chuck Ebbert <76306.1226@compuserve.com>,
       "P @ Draig Brady" <P@draigBrady.com>, Ben Dooks <ben-linux@fluff.org>,
       Dimitry Andric <dimitry.andric@tomtom.com>, Olaf Hering <olh@suse.de>,
       Deepak Saxena <dsaxena@plexity.net>,
       Christer Weinigel <wingel@nano-system.com>
In-Reply-To: <20050906214102.GQ19487@infomag.infomag.iguana.be>
References: <20050903200443.GO19487@infomag.infomag.iguana.be>
	 <1125778302.3223.29.camel@laptopd505.fenrus.org>
	 <20050906214102.GQ19487@infomag.infomag.iguana.be>
Content-Type: text/plain
Date: Sat, 10 Sep 2005 12:08:56 +0200
Message-Id: <1126346936.3222.136.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.0 (++++)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (4.0 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	1.1 SUBJ_HAS_UNIQ_ID       Subject contains a unique ID
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	2.8 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> However, the goal is to make sure that the "watchdog" stays running and
> watches the system and that it in case of abnormal behaviour reboots the system.
> And you can't get that if you delete the timer.

if you want that (as sysadmin) then don't unload the module!



