Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264724AbSLLPMp>; Thu, 12 Dec 2002 10:12:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264730AbSLLPMo>; Thu, 12 Dec 2002 10:12:44 -0500
Received: from mail.dyna-drill.com ([63.237.98.21]:62732 "HELO
	whhouowa.whes.com") by vger.kernel.org with SMTP id <S264724AbSLLPMo> convert rfc822-to-8bit;
	Thu, 12 Dec 2002 10:12:44 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.4712.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RH 8.0 vs. RH7.3 driver issues
Date: Thu, 12 Dec 2002 09:12:47 -0600
Message-ID: <6E921763A81C3A47AAC790EEF69751C021AF88@pfhouex1.whes.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: RH 8.0 vs. RH7.3 driver issues
Thread-Index: AcKh8hfczmncRQ3gEdeQzACQJ3QCdg==
From: "Harlan Jillson" <Harlan.Jillson@pathfinderlwd.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 12 Dec 2002 15:19:48.0830 (UTC) FILETIME=[E90367E0:01C2A1F1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi all,
  I just subscribed to the list, and am looking for some suggestions.
  I have a device driver for a RS485 card that does microlan
communications between several devices.  The driver was written a couple
of years ago using the 2.2 kernel in RH 6.1.  It's was updated for 2.4
kernel when RH7.3 was released and has been working fine.  RH8.0 is
apparently a different story, as there appears to be problems with
scheduled timeouts (polling intervals) and maybe some interrupt issues.
My question is are there any known problems ( RH kernel 2.4.18-3)?  I
know I'm dealing the revamps in the scheduler and timer areas and then
there's the shift from gcc 2.96 to 3.2.  
Thanks for any suggestions,
Harlan
