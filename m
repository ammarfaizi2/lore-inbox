Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161111AbWG1KKc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161111AbWG1KKc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 06:10:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932609AbWG1KKc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 06:10:32 -0400
Received: from styx.suse.cz ([82.119.242.94]:62953 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S932608AbWG1KKb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 06:10:31 -0400
Date: Fri, 28 Jul 2006 12:10:27 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: "Brown, Len" <len.brown@intel.com>,
       Shem Multinymous <multinymous@gmail.com>, Pavel Machek <pavel@suse.cz>,
       kernel list <linux-kernel@vger.kernel.org>,
       linux-thinkpad@linux-thinkpad.org, linux-acpi@vger.kernel.org
Subject: Re: Generic battery interface
Message-ID: <20060728101026.GB25372@suse.cz>
References: <CFF307C98FEABE47A452B27C06B85BB601168B34@hdsmsx411.amr.corp.intel.com> <20060728095806.GA2046@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060728095806.GA2046@srcf.ucam.org>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2006 at 10:58:06AM +0100, Matthew Garrett wrote:
> On Fri, Jul 28, 2006 at 12:05:35AM -0400, Brown, Len wrote:
> 
> > Wonderful, but isn't the key here how simple it is for HAL
> > or X to understand and use the kernel API rather than the
> > developers of the kernel driver that implements the API?
> 
> HAL currently gets most of its information from sysfs, and managed to 
> deal with parsing the existing /proc/acpi/battery stuff. I don't think 
> there's any real difficulty there.
 
Yes, HAL does a lot of ugly work to be able to gather the information it needs.

-- 
Vojtech Pavlik
Director SuSE Labs
