Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314510AbSDSALz>; Thu, 18 Apr 2002 20:11:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314511AbSDSALy>; Thu, 18 Apr 2002 20:11:54 -0400
Received: from sj-msg-core-1.cisco.com ([171.71.163.11]:44941 "EHLO
	sj-msg-core-1.cisco.com") by vger.kernel.org with ESMTP
	id <S314510AbSDSALx>; Thu, 18 Apr 2002 20:11:53 -0400
From: "Hua Zhong" <hzhong@cisco.com>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Tracking io of processes
Date: Thu, 18 Apr 2002 17:11:47 -0700
Message-ID: <FEEFKBEFIEBONNKJABKDMEGDDBAA.hzhong@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:

Is there any way to track how much io (read/write) a certain process has
issued? iostat only works for the whole system. Sometimes we see io bursts
in iostat but don't know which process is doing it (swap usage is 0 so it's
not swapping).

Thanks.

Hua

