Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292363AbSB0MZn>; Wed, 27 Feb 2002 07:25:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292382AbSB0MZ2>; Wed, 27 Feb 2002 07:25:28 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:35857 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S292378AbSB0MZT>; Wed, 27 Feb 2002 07:25:19 -0500
Message-ID: <3C7CCFEB.7CA3CE7B@aitel.hist.no>
Date: Wed, 27 Feb 2002 13:24:11 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.5-dj2 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: Nathan <wfilardo@fuse.net>, linux-kernel@vger.kernel.org, davej@suse.de
Subject: Re: 2.5.5-dj2 compile failures
In-Reply-To: <3C7C4BBF.2020505@fuse.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan wrote:
> 
> First the good news - it built the ALSA modules correctly this time around.

RTC Timer support failed - but maybe I don't need that

Generic ESS ES18xx driver also failed to compile, - so no sound here.

Helge Hafting
