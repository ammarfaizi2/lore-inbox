Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131602AbRA3Wth>; Tue, 30 Jan 2001 17:49:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132549AbRA3Wt2>; Tue, 30 Jan 2001 17:49:28 -0500
Received: from pcow028o.blueyonder.co.uk ([195.188.53.124]:7183 "EHLO
	blueyonder.co.uk") by vger.kernel.org with ESMTP id <S131602AbRA3WtS>;
	Tue, 30 Jan 2001 17:49:18 -0500
Date: Tue, 30 Jan 2001 22:49:12 +0000
From: Michael Pacey <michael@wd21.co.uk>
To: linux-kernel@vger.kernel.org
Subject: Multiple SCSI host adapters, naming of attached devices
Message-ID: <20010130224912.A388@kermit.wd21.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.0.pre5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for posting this here, I'm sure you're all busy with 2.4.1 and 2.2.18
but I'm read the SCSI HOWTO and asked on #LinPeople to no avail:

Given two host adapters each with 1 disk of ID 0, how do I tell Linux which
is sda and which sdb?

After this I'll be filling the 2nd SCSI chain completely, so assigning a
different ID is not an option.

Thanks in advance.

--
Michael Pacey
michael@wd21.co.uk
ICQ: 105498469

wd21 ltd - world domination in the 21st century

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
