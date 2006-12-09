Return-Path: <linux-kernel-owner+w=401wt.eu-S1759128AbWLIWwR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759128AbWLIWwR (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 17:52:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759143AbWLIWwQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 17:52:16 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:33733 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759126AbWLIWwQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 17:52:16 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <457B3E01.4040807@s5r6.in-berlin.de>
Date: Sat, 09 Dec 2006 23:51:45 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.8) Gecko/20061202 SeaMonkey/1.0.6
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: linux1394-devel@lists.sourceforge.net, Pavel Machek <pavel@ucw.cz>,
       Erik Mouw <erik@harddisk-recovery.com>,
       Kristian H?gsberg <krh@redhat.com>,
       Marcel Holtmann <marcel@holtmann.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] New firewire stack
References: <20061205052229.7213.38194.stgit@dinky.boston.redhat.com>	 <1165308400.2756.2.camel@localhost> <45758CB3.80701@redhat.com>	 <20061205160530.GB6043@harddisk-recovery.com>	 <20060712145650.GA4403@ucw.cz>  <45798022.2090104@s5r6.in-berlin.de> <1165701104.1103.159.camel@localhost.localdomain>
In-Reply-To: <1165701104.1103.159.camel@localhost.localdomain>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:
> One of the problems with hpsb_ is that it's a total pain to type
> and doesn't mean anything at first sight :-)

Both prevent that other people snatch this prefix from us. Also, only
people who can recite the meaning of that acronym when asleep are
permitted to call hpsb_ functions in their code. :-)
-- 
Stefan Richter
-=====-=-==- ==-- -=--=
http://arcgraph.de/sr/
