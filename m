Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753259AbWKCPTZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753259AbWKCPTZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 10:19:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753248AbWKCPTY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 10:19:24 -0500
Received: from mail.suse.de ([195.135.220.2]:49609 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1753233AbWKCPTY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 10:19:24 -0500
Date: Fri, 3 Nov 2006 16:13:45 +0100
From: Stefan Seyfried <seife@suse.de>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Shem Multinymous <multinymous@gmail.com>,
       David Zeuthen <davidz@redhat.com>, Richard Hughes <hughsient@gmail.com>,
       David Woodhouse <dwmw2@infradead.org>, Dan Williams <dcbw@redhat.com>,
       linux-kernel@vger.kernel.org, devel@laptop.org, sfr@canb.auug.org.au,
       len.brown@intel.com, benh@kernel.crashing.org,
       linux-thinkpad mailing list <linux-thinkpad@linux-thinkpad.org>,
       Pavel Machek <pavel@suse.cz>, Jean Delvare <khali@linux-fr.org>,
       Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [ltp] Re: [PATCH v2] Re: Battery class driver.
Message-ID: <20061103151345.GA31829@suse.de>
References: <1162041726.16799.1.camel@hughsie-laptop> <1162048148.2723.61.camel@zelda.fubar.dk> <41840b750610281112q7790ecao774b3d1b375aca9b@mail.gmail.com> <20061031074946.GA7906@kroah.com> <41840b750610310528p4b60d076v89fc7611a0943433@mail.gmail.com> <20061101193134.GB29929@kroah.com> <41840b750611011153w3a2ace72tcdb45a446e8298@mail.gmail.com> <20061101205330.GA2593@kroah.com> <20061101235540.GA11581@khazad-dum.debian.net> <454A2FC2.4060107@tmr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <454A2FC2.4060107@tmr.com>
X-Operating-System: openSUSE 10.2 (i586) Beta2, Kernel 2.6.18.1-12-default
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02, 2006 at 12:49:54PM -0500, Bill Davidsen wrote:

> Having seen a French consultant with a Windows laptop reporting mJ 

Hehe.... That's the nice thing about SI units.

     1W = 1J / 1s

so
 
 1W * 1h = 3600s * 1J / 1s
    1mWh = 3.6J

If i did not screw up something :-). I still wonder why they would
report mJ, but probably they like big numbers ;-)
-- 
Stefan Seyfried
QA / R&D Team Mobile Devices        |              "Any ideas, John?"
SUSE LINUX Products GmbH, Nürnberg  | "Well, surrounding them's out." 
