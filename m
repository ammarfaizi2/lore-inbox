Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261928AbTEFV2j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 17:28:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261960AbTEFV2j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 17:28:39 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:3223 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261928AbTEFV2i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 17:28:38 -0400
Date: Tue, 6 May 2003 14:12:10 -0700
From: Greg KH <greg@kroah.com>
To: Daniel Pittman <daniel@rimspace.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CPUFreq sysfs interface MIA?
Message-ID: <20030506211210.GA3148@kroah.com>
References: <873cjsv8hg.fsf@enki.rimspace.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <873cjsv8hg.fsf@enki.rimspace.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 06, 2003 at 05:29:15PM +1000, Daniel Pittman wrote:
> 
> The content of /sys/devices/sys/cpu0 is:
> /sys/devices/sys/cpu0
> |-- name
> `-- power

What does /sys/class/cpu show?

thanks,

greg k-h
