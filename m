Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264923AbRF0RiM>; Wed, 27 Jun 2001 13:38:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265136AbRF0RiC>; Wed, 27 Jun 2001 13:38:02 -0400
Received: from adsl-65-69-43-155.dsl.stlsmo.swbell.net ([65.69.43.155]:4480
	"HELO sbox.labfire.com") by vger.kernel.org with SMTP
	id <S264923AbRF0Rhq>; Wed, 27 Jun 2001 13:37:46 -0400
Date: Wed, 27 Jun 2001 12:37:35 -0500
From: Ian Wehrman <ian@labfire.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.5-ac19 appletalk unresolved symbols
Message-ID: <20010627123735.A1013@labfire.com>
Reply-To: ian@labfire.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.5-ac series (i'm not sure exactly when it started) shows unresolved
symbols for the appletalk module:

($:~)-> modprobe appletalk
/lib/modules/2.4.5-ac19/kernel/net/appletalk/appletalk.o: unresolved symbol
unregister_snap_client_R9abefc50
/lib/modules/2.4.5-ac19/kernel/net/appletalk/appletalk.o: unresolved symbol
register_snap_client_R3addf9f1
/lib/modules/2.4.5-ac19/kernel/net/appletalk/appletalk.o: insmod
/lib/modules/2.4.5-ac19/kernel/net/appletalk/appletalk.o failed
/lib/modules/2.4.5-ac19/kernel/net/appletalk/appletalk.o: insmod appletalk
failed

thanks,
ian wehrman

-- 
Labfire, Inc.
Seamless Technical Solutions
http://labfire.com/
