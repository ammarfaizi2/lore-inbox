Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267163AbTAPQRk>; Thu, 16 Jan 2003 11:17:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267178AbTAPQRk>; Thu, 16 Jan 2003 11:17:40 -0500
Received: from d12lmsgate-3.de.ibm.com ([194.196.100.236]:51391 "EHLO
	d12lmsgate-3.de.ibm.com") by vger.kernel.org with ESMTP
	id <S267163AbTAPQRj>; Thu, 16 Jan 2003 11:17:39 -0500
Subject: processes or threads
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OF5EA7F5CC.79559DF9-ONC1256CB0.00544942@italy.ibm.com>
From: "Salvatore D'Angelo" <SDANGELO@it.ibm.com>
Date: Thu, 16 Jan 2003 16:33:27 +0100
X-MIMETrack: Serialize by Router on D14ML005/14/M/IBM(Release 5.0.9a |January 7, 2002) at
 16/01/2003 17:26:29
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Can someone of you tell me if there is a way to understand (in user space
through proc filesystem) if a thread (or process) has been created using a
fork or a clone. I am writing a small library that parse the proc
filesystem to get all the processes currently in execution.

The problem is that the client application need only the processes created
with the fork system call.

I tried to understand the solution looking at the linux source code and
making a search on the MARC mail list but I haven't found the solution.

Thanks in advance for any suggestions.

PS

I am not subscribed to this mail list, so please when reply put my address
in cc.

