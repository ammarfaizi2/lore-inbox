Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313658AbSDJWb6>; Wed, 10 Apr 2002 18:31:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313912AbSDJWb5>; Wed, 10 Apr 2002 18:31:57 -0400
Received: from rwcrmhc54.attbi.com ([216.148.227.87]:53436 "EHLO
	rwcrmhc54.attbi.com") by vger.kernel.org with ESMTP
	id <S313658AbSDJWb4>; Wed, 10 Apr 2002 18:31:56 -0400
From: "Guillaume Boissiere" <boissiere@attbi.com>
To: linux-kernel@vger.kernel.org
Date: Wed, 10 Apr 2002 18:31:46 -0400
MIME-Version: 1.0
Subject: [STATUS]  Spring cleanup
Message-ID: <3CB48512.17441.E3FE393@localhost>
X-mailer: Pegasus Mail for Windows (v4.01)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These four items have been marked as Ready or Pending for a while and yet nothing 
has happened for the last 2 months so I'm planning to change their status in the
next status update.
Comments?  Objections?

-- Guillaume



o Ready       Add hardware sensors drivers                    (lm_sensors team)
--> Mark as Beta?  Reason: not in sync with latest kernel and problems with IBM Thinkpads

o Ready       New kernel config system: CML2                  (Eric Raymond)
--> Mark as Beta?  Reason: needs to be broken up in chunks before inclusion

o Ready       Read-Copy Update Mutual Exclusion               (Dipankar Sarma, Rusty Russell, Andrea Arcangeli, LSE 
Team)
--> Mark as Beta?  Reason: patch exists against 2.5.7, but not sure if it needs more work 
    before inclusion or there is objection from Linus?

o Pending     Finalize new device naming convention           (Linus Torvalds)
--> ???  I am not sure what is going on here -- it seems Linus is waiting for someone to step up and 
    submit a patch following the new device naming convention he vaguely outlined a while back?

