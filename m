Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262449AbVFWMyE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262449AbVFWMyE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 08:54:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262457AbVFWMyE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 08:54:04 -0400
Received: from linuxwireless.org.ve.carpathiahost.net ([66.117.45.234]:46730
	"EHLO linuxwireless.org.ve.carpathiahost.net") by vger.kernel.org
	with ESMTP id S262455AbVFWMx5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 08:53:57 -0400
Reply-To: <abonilla@linuxwireless.org>
From: "Alejandro Bonilla" <abonilla@linuxwireless.org>
To: "'Eric Piel'" <Eric.Piel@tremplin-utc.net>,
       "'Vojtech Pavlik'" <vojtech@suse.cz>, <borislav@users.sourceforge.net>
Cc: "'Pavel Machek'" <pavel@ucw.cz>, "'Lee Revell'" <rlrevell@joe-job.com>,
       "'Yani Ioannou'" <yani.ioannou@gmail.com>,
       <linux-thinkpad@linux-thinkpad.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [ltp] Re: IBM HDAPS Someone interested?
Date: Thu, 23 Jun 2005 06:53:15 -0600
Message-ID: <004001c577f2$865ab650$600cc60a@amer.sykes.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <42BA89B4.50900@tremplin-utc.net>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1478
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  
> > But that doesn't mean it's not connected to the embedded 
> controller. It
> > just means the embedded controller doesn't generate any 
> inertial events
> > by itself - it may have to be polled with some specific command.
> > 
> 
> Well, in the changelog of the embedded controller firmware 
> (ftp://ftp.software.ibm.com/pc/pccbbs/mobiles/1uhj07us.txt) there is:
> - (New) Support for IBM Hard Disk Active Protection System.
> 
> I would conclude that the embedded controller is involved 
> with the HDAPS!
> 
> Just my two cents.
> 
> Eric
> 
OK, awesome. This gives us pretty much a where to go from now.

Should the IBM-ACPI project have anything to do with this? I mean, we should, or could be getting more -vvv information from ecdump or the fact that because this is attached to the embedded controller makes things harder?

.Alejandro

