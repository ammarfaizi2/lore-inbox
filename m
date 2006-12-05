Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968400AbWLEQFj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968400AbWLEQFj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 11:05:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968402AbWLEQFj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 11:05:39 -0500
Received: from dtp.xs4all.nl ([80.126.206.180]:39281 "HELO abra2.bitwizard.nl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S968400AbWLEQFh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 11:05:37 -0500
Date: Tue, 5 Dec 2006 17:05:30 +0100
From: Erik Mouw <erik@harddisk-recovery.com>
To: Kristian =?iso-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-kernel@vger.kernel.org,
       Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [PATCH 0/3] New firewire stack
Message-ID: <20061205160530.GB6043@harddisk-recovery.com>
References: <20061205052229.7213.38194.stgit@dinky.boston.redhat.com> <1165308400.2756.2.camel@localhost> <45758CB3.80701@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <45758CB3.80701@redhat.com>
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2006 at 10:13:55AM -0500, Kristian Høgsberg wrote:
> Marcel Holtmann wrote:
> >can you please use drivers/firewire/ if you want to start clean or
> >aiming at replacing drivers/ieee1394/. Using "fw" as an abbreviation in
> >the directory path is not really helpful.
> 
> Yes, that's probably a better idea.  Do you see a problem with using fw_* 
> as a prefix in the code though?  I don't see anybody using that prefix, but 
> Stefan pointed out to me that it's often used to abbreviate firmware too.

So what about fiwi_*? If that's too close to wifi_*, try frwr_.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
