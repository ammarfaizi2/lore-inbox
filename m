Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280585AbRKNNSr>; Wed, 14 Nov 2001 08:18:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280586AbRKNNSg>; Wed, 14 Nov 2001 08:18:36 -0500
Received: from odysseus2.dohle.com ([194.127.185.20]:52753 "EHLO
	odysseus2.dohle.com") by vger.kernel.org with ESMTP
	id <S280585AbRKNNSW> convert rfc822-to-8bit; Wed, 14 Nov 2001 08:18:22 -0500
Reply-To: <kmeyer@dohle.com>
From: "Klaus Meyer" <kmeyer@dohle.com>
To: <linux-kernel@vger.kernel.org>
Subject: ServerWorks 
Date: Wed, 14 Nov 2001 14:17:16 +0100
Message-ID: <00fb01c16d0e$af0b7d20$5ebe7fc2@dohle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook 8.5, Build 4.71.2377.0
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

we have big Problems with IBM Netfinity Servers with ServerWorks ChipSet 3HE. The machine comes with an IBM ServeRaid Controller 4L and an Raid 0 is build with 4 Harddisks. If a dd is made on the raid (dd if=/dev/zero of=/dev/sda1 bs=1M count=2000; sync) and the sync starts all 4 CPUs are 100% buisy. Till the sync is done, the server is not able to do anything else.
On a SuperMicro 8060 with Chipset ServerWorks 3HE happens the same. 

Any suggestions ?

Tanks
Klaus Meyer

 

