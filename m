Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278468AbRJZN06>; Fri, 26 Oct 2001 09:26:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278470AbRJZN0j>; Fri, 26 Oct 2001 09:26:39 -0400
Received: from [202.54.64.2] ([202.54.64.2]:38918 "EHLO ganesh.ctd.hctech.com")
	by vger.kernel.org with ESMTP id <S278468AbRJZN0e>;
	Fri, 26 Oct 2001 09:26:34 -0400
Message-ID: <EF836A380096D511AD9000B0D021B52723D9DE@narmada.ctd.hcltech.com>
From: "ASAI THAMBI S.P - CTD, Chennai." <sp_asai@ctd.hcltech.com>
To: linux-kernel@vger.kernel.org
Subject: open a file in kernel mode in solaris
Date: Fri, 26 Oct 2001 18:55:32 +0530
Importance: high
X-Priority: 1
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In linux, 
we can open a file in kernel mode using some functions like set_fs(),
get_fs()...
Moreover to call sys-open, we do so thru sys_call_table[__NR_open].


In Solaris, 
how can we do this?

asai. 


***********************************************************************
Disclaimer: 
This document is intended for transmission to the named recipient only.  If
you are not that person, you should note that legal rights reside in this
document and you are not authorized to access, read, disclose, copy, use or
otherwise deal with it and any such actions are prohibited and may be
unlawful. The views expressed in this document are not necessarily those of
HCL Technologies Ltd. Notice is hereby given that no representation,
contract or other binding obligation shall be created by this e-mail, which
must be interpreted accordingly. Any representations, contractual rights or
obligations shall be separately communicated in writing and signed in the
original by a duly authorized officer of the relevant company.
***********************************************************************


