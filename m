Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129153AbQKYHJe>; Sat, 25 Nov 2000 02:09:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129183AbQKYHJY>; Sat, 25 Nov 2000 02:09:24 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:19214 "EHLO
        vger.timpanogas.org") by vger.kernel.org with ESMTP
        id <S129153AbQKYHJI>; Sat, 25 Nov 2000 02:09:08 -0500
Date: Sat, 25 Nov 2000 00:36:00 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: linux-kernel@vger.kernel.org
Subject: setting up pppd dial-in on linux 
Message-ID: <20001125003600.A28207@vger.timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Anyone out there a whiz at setting up a pppd dialin server?  I am 
trying to put together an RPM for pppd dialin configurations
that will support default Windows NT and Linux dial in clients
without requiring the poor user to learn bash scripting, chat 
scripting, mgetty and inittab configuration, etc.  The steps
in setting this up are about as easy as going on a U.N. relief
mission to equatorial Africa, and most customers who are 
"mere mortals" would give up about an hour into it.

I am seeing massive problems with pppd dial-in and IP/IPX 
routing with problems that range from constant Oops, to 
the bug infested pppd daemon failing valid MD5 chap 
authentication.  The HOW-TO's and man pages provide 
wonderful commentary on all the things about pppd 
that don't work, but it's not too helpful on getting
it to work reliably.  An NT dial-in server takes about
5 minutes to configure on W2K.  Linux takes about 2 days, and 
won't stay up reliably.  

Who out there is an expert on Linux pppd that would like
to help put together some easy configs for standard 
dial-in scenarios?

Thanks

Jeff



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
