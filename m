Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280026AbRK0PJR>; Tue, 27 Nov 2001 10:09:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280805AbRK0PIR>; Tue, 27 Nov 2001 10:08:17 -0500
Received: from smtp102.urscorp.com ([65.207.129.233]:28179 "EHLO
	smtp102.urscorp.com") by vger.kernel.org with ESMTP
	id <S280190AbRK0PHK>; Tue, 27 Nov 2001 10:07:10 -0500
To: "Martin A. Brooks" <martin@jtrix.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 'spurious 8259A interrupt: IRQ7'
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
From: mike_phillips@urscorp.com
Message-ID: <OF508D235C.0A51F5DD-ON85256B11.004D2BC9@urscorp.com>
Date: Tue, 27 Nov 2001 10:04:05 -0500
X-MIMETrack: Serialize by Router on SMTP102/URSCorp(Release 5.0.5 |September 22, 2000) at
 11/27/2001 10:05:51 AM,
	Serialize complete at 11/27/2001 10:05:51 AM
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In my research before posting, a common thread seemed to be the presence 
of
> a tulip card in the machine.  Has anyone seen this on a non-tulip box?

Does the same on my laptop, but only after the 3C575 cardbus adapter is 
plugged in (using the 3c59x driver).

Mike

