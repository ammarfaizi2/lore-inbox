Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264659AbSLaQ0z>; Tue, 31 Dec 2002 11:26:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264690AbSLaQ0y>; Tue, 31 Dec 2002 11:26:54 -0500
Received: from Mail.CERT.Uni-Stuttgart.DE ([129.69.16.17]:64926 "EHLO
	Mail.CERT.Uni-Stuttgart.DE") by vger.kernel.org with ESMTP
	id <S264659AbSLaQ0y>; Tue, 31 Dec 2002 11:26:54 -0500
To: linux-kernel@vger.kernel.org
Subject: NIC with polling support
Mail-Followup-To: linux-kernel@vger.kernel.org
From: Florian Weimer <Weimer@CERT.Uni-Stuttgart.DE>
Date: Tue, 31 Dec 2002 17:35:19 +0100
Message-ID: <87el7yrvso.fsf@Login.CERT.Uni-Stuttgart.DE>
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) Emacs/21.2 (i386-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

I guess I'm severe need of a 100BaseTX NIC with polling support in the
driver.

A special application requires processing of 40,000 packets/second or
more, and the interrupt load currently kills the machine (i.e. no
scheduling during peak load).

Any suggestions which card I should use?  The driver has to be open
source, and the card shouldn't be too expensive (i.e. in the usual
price range of brand 100BaseTX NICs).

Thanks,
-- 
Florian Weimer 	                  Weimer@CERT.Uni-Stuttgart.DE
University of Stuttgart           http://CERT.Uni-Stuttgart.DE/people/fw/
RUS-CERT                          fax +49-711-685-5898
