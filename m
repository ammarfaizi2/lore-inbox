Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262344AbSJQXaQ>; Thu, 17 Oct 2002 19:30:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262352AbSJQXaQ>; Thu, 17 Oct 2002 19:30:16 -0400
Received: from momus.sc.intel.com ([143.183.152.8]:41154 "EHLO
	momus.sc.intel.com") by vger.kernel.org with ESMTP
	id <S262344AbSJQXaP>; Thu, 17 Oct 2002 19:30:15 -0400
Message-ID: <288F9BF66CD9D5118DF400508B68C44604758BCE@orsmsx113.jf.intel.com>
From: "Feldman, Scott" <scott.feldman@intel.com>
To: "'David S. Miller'" <davem@redhat.com>, roy@karlsbakk.net
Cc: linux-kernel@vger.kernel.org
Subject: RE: TCP Segmentation Offload (TSO) in 2.4?
Date: Thu, 17 Oct 2002 16:35:18 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It isn't hard, but two issues:
> 
> 1) You'll only get this with e1000 cards, and there were some
>    performance regression noted by some testers at IBM with
>    TSO enabled.

Was this posted to the list?  I remember Troy's results showing positive
results with TSO over SPECWeb.  

-scott
