Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262226AbTEGAZr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 20:25:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262232AbTEGAZa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 20:25:30 -0400
Received: from 130.146.174.203.mel.ntt.net.au ([203.174.146.130]:43138 "EHLO
	enki.rimspace.net") by vger.kernel.org with ESMTP id S262226AbTEGAXi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 20:23:38 -0400
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CPUFreq sysfs interface MIA?
In-Reply-To: <20030506211210.GA3148@kroah.com> (Greg KH's message of "Tue, 6
 May 2003 14:12:10 -0700")
References: <873cjsv8hg.fsf@enki.rimspace.net>
	<20030506211210.GA3148@kroah.com>
From: Daniel Pittman <daniel@rimspace.net>
Date: Wed, 07 May 2003 10:36:09 +1000
Message-ID: <87n0hzbnk6.fsf@enki.rimspace.net>
User-Agent: Gnus/5.090016 (Oort Gnus v0.16) XEmacs/21.5 (cabbage)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 May 2003, Greg KH wrote:
> On Tue, May 06, 2003 at 05:29:15PM +1000, Daniel Pittman wrote:
>> 
>> The content of /sys/devices/sys/cpu0 is:
>> /sys/devices/sys/cpu0
>> |-- name
>> `-- power
> 
> What does /sys/class/cpu show?

/sys/class/cpu
`-- cpu0
    `-- device -> ../../../devices/sys/cpu0

2 directories, 0 files

  Daniel

-- 
He uses hate as a weapon to defend himself; had he been strong,
he would never have needed that kind of weapon.
        -- Kahlil Gibran
