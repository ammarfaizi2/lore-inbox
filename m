Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261681AbVDESow@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261681AbVDESow (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 14:44:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261622AbVDESnI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 14:43:08 -0400
Received: from rproxy.gmail.com ([64.233.170.204]:24651 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261890AbVDESiA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 14:38:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=ZEVAAHE7pB3zfF3jUSDrswEa0s84Uqkf2oDeIbiFpR3yXyZD36zgCljResLiWlvbD2c8CkvhqIT3zDUJheKKSrLvz01A5kf8VFybFcsfeIEy5KRv0p1+dbJKQD7MEuQiWATMovLt7+Hn0+a9hAa28bjUMOt8fAxNZYu0JQzTvX0=
Message-ID: <d120d500050405113744837bd7@mail.gmail.com>
Date: Tue, 5 Apr 2005 13:37:57 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Stefan Seyfried <seife@suse.de>
Subject: Re: i8042 controller on Toshiba Satellite P10 notebook - patch
Cc: Jaco Kroon <jaco@kroon.co.za>, linux-kernel@vger.kernel.org,
       Sebastian Piechocki <sebekpi@poczta.onet.pl>
In-Reply-To: <4252D6F8.6000707@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <425166F9.1040800@kroon.co.za>
	 <d120d5000504040954354fb3fa@mail.gmail.com>
	 <42517442.20602@kroon.co.za>
	 <d120d500050404110374fe9deb@mail.gmail.com>
	 <4251A515.8040802@kroon.co.za>
	 <d120d500050404140253a77ab8@mail.gmail.com>
	 <4251B6E2.3010506@kroon.co.za>
	 <d120d50005040415506cd87287@mail.gmail.com>
	 <4251D3CB.4010501@kroon.co.za> <4252D6F8.6000707@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 5, 2005 1:20 PM, Stefan Seyfried <seife@suse.de> wrote:
> Jaco Kroon wrote:
> > Dmitry Torokhov wrote:
> 
> >>>OT:  I think I prefer synaptics multi-finger tapping to the tapping in
> >>>specific locations to get right and middle clicking, but that is another
> >>>story that probably has nothing to do with the kernel, and quite likely
> >>>something that is configurable in the synaptics xorg driver.
> >>
> >> You should be able to control that in xorg.conf.
> >
> > My thoughts exactly.  The same goes for gpm.
> 
> No. AFAIK multifinger taps are handled by the touchpad firmware, but not
> on ALPS touchpads, only on synaptics.
> 

Yes, you are right... I meant one could remap actions to corner and
multi-finger taps in xorg.conf but if hardware does not recognize
multi-finger taps then you are out of luck.

-- 
Dmitry
