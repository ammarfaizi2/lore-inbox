Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272233AbRIOKi2>; Sat, 15 Sep 2001 06:38:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272247AbRIOKiR>; Sat, 15 Sep 2001 06:38:17 -0400
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:48140 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S272244AbRIOKiM>; Sat, 15 Sep 2001 06:38:12 -0400
Date: Sat, 15 Sep 2001 12:38:31 +0200
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: Arjan Filius <iafilius@xs4all.nl>
Cc: Robert Love <rml@tech9.net>, linux-kernel@vger.kernel.org
Subject: Re: Feedback on preemptible kernel patch
Message-ID: <20010915123831.G7988@arthur.ubicom.tudelft.nl>
In-Reply-To: <1000479851.2156.12.camel@phantasy> <Pine.LNX.4.33.0109151131320.32167-100000@sjoerd.sjoerdnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0109151131320.32167-100000@sjoerd.sjoerdnet>; from iafilius@xs4all.nl on Sat, Sep 15, 2001 at 11:44:57AM +0200
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 15, 2001 at 11:44:57AM +0200, Arjan Filius wrote:

Hi Arjan,

> But /proc/interrupts shows only those irq's which are currently in use, is
> there any way to show usage of currenlty unused interrupts?

Yes, /proc/stat. The "intr" line shows the total number of interrupts
and the number of interrupts for each interrupt line.


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
