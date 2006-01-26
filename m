Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932156AbWAZSjc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932156AbWAZSjc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 13:39:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751357AbWAZSjb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 13:39:31 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:28112 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751349AbWAZSjb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 13:39:31 -0500
Date: Thu, 26 Jan 2006 19:38:37 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Olivier Galibert <galibert@pobox.com>
cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
In-Reply-To: <20060126182818.GA44822@dspnet.fr.eu.org>
Message-ID: <Pine.LNX.4.61.0601261938180.14581@yvahk01.tjqt.qr>
References: <787b0d920601241858w375a42efnc780f74b5c05e5d0@mail.gmail.com>
 <43D7A7F4.nailDE92K7TJI@burner> <8614E822-9ED1-4CB1-B8F0-7571D1A7767E@mac.com>
 <43D7B1E7.nailDFJ9MUZ5G@burner> <20060125230850.GA2137@merlin.emma.line.org>
 <43D8C04F.nailE1C2X9KNC@burner> <20060126161028.GA8099@suse.cz>
 <20060126175506.GA32972@dspnet.fr.eu.org> <20060126181034.GA9694@suse.cz>
 <20060126182818.GA44822@dspnet.fr.eu.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Udev interfaces that and can be set up so that it assigns
>> /dev/cdrecorder0, 1, ... to evey recorder in the system, implementing
>> the userspace interface.
>
>Problem is, udev doesn't.  Or at least it varies from distribution to
>distribution.  For instance recent gentoo creates /dev/cdrom*,
>/dev/cdrw*, /dev/dvd*, /dev/dvdrw*.  Fedora core 3 creates
>/dev/cdrom*, /dev/cdwriter*, /dev/dvd*, /dev/dvdwriter*.  I guess from
>your email that SuSE does /dev/cdrecorder*.  And I'm not able to
>guess what fedora core 5, mandrake, debian, slackware and infinite
>number of derivatives do.

Plus you have to think about systems not using udev at all.
Cheers, chaos preprogrammed.


Jan Engelhardt
-- 
