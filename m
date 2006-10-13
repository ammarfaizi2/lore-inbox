Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751883AbWJMUaJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751883AbWJMUaJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 16:30:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751882AbWJMUaJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 16:30:09 -0400
Received: from tirith2.ics.muni.cz ([147.251.4.39]:64975 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S1751883AbWJMUaH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 16:30:07 -0400
Date: Fri, 13 Oct 2006 22:30:04 +0200
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: Aleksey Gorelov <dared1st@yahoo.com>
Cc: Auke Kok <auke-jan.h.kok@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: Machine reboot
Message-ID: <20061013203004.GI3039@mail.muni.cz>
References: <452F1142.3000400@intel.com> <20061013202752.4101.qmail@web83103.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20061013202752.4101.qmail@web83103.mail.mud.yahoo.com>
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, bomb
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Muni-Spam-TestIP: 81.31.45.161
X-Muni-Envelope-From: xhejtman@fi.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2006 at 01:27:52PM -0700, Aleksey Gorelov wrote:
> It's not the problem at all, but served as a hint for me to try unloading driver.
> However, from latest Lukas's findings, it seems that something (_not_ in the e1000 driver) in
> between 2.6.18 & 2.6.19-rc2 fixes it. 

Does 2.6.19-rc1 work for you? Both with module and built in e1000 driver?

-- 
Luká¹ Hejtmánek
