Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267344AbUJRSmv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267344AbUJRSmv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 14:42:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267338AbUJRSfB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 14:35:01 -0400
Received: from mx1.redhat.com ([66.187.233.31]:2184 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267254AbUJRScK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 14:32:10 -0400
To: Greg KH <greg@kroah.com>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org,
       Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: forcing PS/2 USB emulation off
References: <orzn2lyw8k.fsf@livre.redhat.lsd.ic.unicamp.br>
	<200410172248.16571.dtor_core@ameritech.net>
	<20041018164539.GC18169@kroah.com>
From: Alexandre Oliva <aoliva@redhat.com>
Organization: Red Hat Global Engineering Services Compiler Team
Date: 18 Oct 2004 15:31:55 -0300
In-Reply-To: <20041018164539.GC18169@kroah.com>
Message-ID: <orbrezdgis.fsf@livre.redhat.lsd.ic.unicamp.br>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 18, 2004, Greg KH <greg@kroah.com> wrote:

> Is there any consistancy with the type of hardware that you see being
> reported for this issue?

I've googled around and found a lot of reports of such issues on the
HP Presario 3000Z series, as well as some other HP notebook series
(nx5000?) that (kind of :-) supports Athlon64 processors.

-- 
Alexandre Oliva             http://www.ic.unicamp.br/~oliva/
Red Hat Compiler Engineer   aoliva@{redhat.com, gcc.gnu.org}
Free Software Evangelist  oliva@{lsd.ic.unicamp.br, gnu.org}
