Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262585AbUEFPnd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262585AbUEFPnd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 11:43:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262730AbUEFPnd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 11:43:33 -0400
Received: from upco.es ([130.206.70.227]:62174 "EHLO mail1.upco.es")
	by vger.kernel.org with ESMTP id S262585AbUEFPna (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 11:43:30 -0400
Date: Thu, 6 May 2004 17:43:28 +0200
From: Romano Giannetti <romano@dea.icai.upco.es>
To: Rob Landley <rob@landley.net>
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: uspend to Disk - Kernel 2.6.4 vs. r50p
Message-ID: <20040506154328.GA6245@pern.dea.icai.upco.es>
Reply-To: romano@dea.icai.upco.es
Mail-Followup-To: Romano Giannetti <romano@dea.icai.upco.es>,
	Rob Landley <rob@landley.net>, Pavel Machek <pavel@ucw.cz>,
	linux-kernel@vger.kernel.org
References: <20040429064115.9A8E814D@damned.travellingkiwi.com> <20040503123150.GA1188@openzaurus.ucw.cz> <200405042018.23043.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <200405042018.23043.rob@landley.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 04, 2004 at 08:18:23PM -0500, Rob Landley wrote:

> I'm one of the people for whom Patrick's suspend worked and yours didn't.  Now 
> I've been busy with other things for a couple months (Penguicon 2.0 went 
> quite well, by the way), and there's talk of yanking Patrick's suspend code 
> from the kernel.  Right, so I've got to deal with this.  I can't say I'm 
> thrilled, but I DO want to continue to be able to suspend my laptop.

Hi! 
    Just a couple of lines to tell you that I was convinced of the same (PM
    works, SWSUSP-vanilla no). But from 2.6.3 --- to which I am stuck, had
    no time to play, just to work, with my laptop till then --- swsusp works
    quite well (modulo pcmcia modem sometime getting stuck after resume and
    sometime no, misteries of life). Pavel told me that if PMDISK worked,
    SWSUSP (vanilla) should work, too, and he was right (tm). 

    The other way around is trying suspend2, given that Nigel is very
    responsive; it will be the first thing I'll try again when having a
    little time after IMTC04. It didn't work one month ago, but Nigel thinks
    he have fixed it. 

    By the way, I have a vaio FX701. 

                Romano     

-- 
Romano Giannetti             -  Univ. Pontificia Comillas (Madrid, Spain)
Electronic Engineer - phone +34 915 422 800 ext 2416  fax +34 915 596 569
