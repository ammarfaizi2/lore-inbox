Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131232AbQKAENM>; Tue, 31 Oct 2000 23:13:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131254AbQKAENC>; Tue, 31 Oct 2000 23:13:02 -0500
Received: from best.micron.net ([204.229.122.199]:48852 "EHLO best.micron.net")
	by vger.kernel.org with ESMTP id <S131232AbQKAEMn>;
	Tue, 31 Oct 2000 23:12:43 -0500
Message-ID: <004d01c043b9$e9cfe2e0$53b613d1@micron.net>
From: "Anonymous" <anonymos@micron.net>
To: <linux-kernel@vger.kernel.org>
Subject: 1.2.45 Linux Scheduler
Date: Tue, 31 Oct 2000 20:12:12 -0800
Organization: Software Solutions
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
X-SMTP-HELO: micron
X-SMTP-MAIL-FROM: anonymos@micron.net
X-SMTP-PEER-INFO: [209.19.182.83]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the Linux scheduler they use a circular queue implementation with round
robin. What is the advantage of this over just using a normal queue with a
back and front. Also does anyone know what a test plan for such a design
would even begin to look like. This is a project for a proposal going around
in my neighborhood and I am wondering why in the world someone would want to
modify the Linux scheduler to this extent.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
