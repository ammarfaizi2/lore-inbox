Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310981AbSCMSyh>; Wed, 13 Mar 2002 13:54:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310989AbSCMSy1>; Wed, 13 Mar 2002 13:54:27 -0500
Received: from cm-24-25-132-100.nycap.rr.com ([24.25.132.100]:1922 "EHLO lain")
	by vger.kernel.org with ESMTP id <S310981AbSCMSyS>;
	Wed, 13 Mar 2002 13:54:18 -0500
Subject: ACPI (not) interfacing w/ laptop
From: Brenden Conte <conteb@rpi.edu>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 13 Mar 2002 13:51:37 -0500
Message-Id: <1016045497.5283.2.camel@lain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't think that the ACPI can / is interfacing with my bios properly. 
On every "event", like closing the laptop for example, generates

"ecgpe-0131 [05] ec_gpe_handler        : Unable to send 'query command'
to EC"

Does this mean i should just stick with APM?  Is there something i can
do to help figure out how to make it work?

thanks,
Brenden 


