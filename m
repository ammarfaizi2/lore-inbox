Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261869AbVDET74@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261869AbVDET74 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 15:59:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261858AbVDESaU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 14:30:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:20125 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261885AbVDESVs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 14:21:48 -0400
Message-ID: <4252D6F8.6000707@suse.de>
Date: Tue, 05 Apr 2005 20:20:40 +0200
From: Stefan Seyfried <seife@suse.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jaco Kroon <jaco@kroon.co.za>
Cc: linux-kernel@vger.kernel.org, Sebastian Piechocki <sebekpi@poczta.onet.pl>,
       dtor_core@ameritech.net
Subject: Re: i8042 controller on Toshiba Satellite P10 notebook - patch
References: <425166F9.1040800@kroon.co.za>	 <d120d5000504040954354fb3fa@mail.gmail.com>	 <42517442.20602@kroon.co.za>	 <d120d500050404110374fe9deb@mail.gmail.com>	 <4251A515.8040802@kroon.co.za>	 <d120d500050404140253a77ab8@mail.gmail.com>	 <4251B6E2.3010506@kroon.co.za> <d120d50005040415506cd87287@mail.gmail.com> <4251D3CB.4010501@kroon.co.za>
In-Reply-To: <4251D3CB.4010501@kroon.co.za>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jaco Kroon wrote:
> Dmitry Torokhov wrote:

>>>OT:  I think I prefer synaptics multi-finger tapping to the tapping in
>>>specific locations to get right and middle clicking, but that is another
>>>story that probably has nothing to do with the kernel, and quite likely
>>>something that is configurable in the synaptics xorg driver.
>> 
>> You should be able to control that in xorg.conf.
> 
> My thoughts exactly.  The same goes for gpm.

No. AFAIK multifinger taps are handled by the touchpad firmware, but not
on ALPS touchpads, only on synaptics.

Regards,

   Stefan
