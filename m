Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262709AbUBZHal (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 02:30:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262715AbUBZHal
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 02:30:41 -0500
Received: from wiproecmx1.wipro.com ([164.164.31.5]:29874 "EHLO
	wiproecmx1.wipro.com") by vger.kernel.org with ESMTP
	id S262709AbUBZHaj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 02:30:39 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Arm UART FIFO
Date: Thu, 26 Feb 2004 13:00:34 +0530
Message-ID: <DC91351678E31E4FB24B551221F507ECB61126@blr-itp-msg.wipro.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Arm UART FIFO
Thread-Index: AcP8OmuTs3OXU2KcTP29LAGX8ctQ2A==
From: <vivek.rangi@wipro.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 26 Feb 2004 07:30:34.0914 (UTC) FILETIME=[6C248020:01C3FC3A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
    I am using 16650 UART for arm processor.They are mentioning that it
has got 32 bytes tranmitter FIFO and 32 words reciever FIFO.But the
number of transmitter and reciever registers are only 16(16 for Tx and
16 for Rx).How can 32 bytes of data be transferred at a time?
Regards,
Vivek
