Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263388AbSJFMQK>; Sun, 6 Oct 2002 08:16:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263390AbSJFMQK>; Sun, 6 Oct 2002 08:16:10 -0400
Received: from petasus.ch.intel.com ([143.182.124.5]:2887 "EHLO
	petasus.ch.intel.com") by vger.kernel.org with ESMTP
	id <S263388AbSJFMQK>; Sun, 6 Oct 2002 08:16:10 -0400
Message-ID: <288F9BF66CD9D5118DF400508B68C44604758AF7@orsmsx113.jf.intel.com>
From: "Feldman, Scott" <scott.feldman@intel.com>
To: "'Ben Greear'" <greearb@candelatech.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       "'netdev@oss.sgi.com'" <netdev@oss.sgi.com>
Subject: RE: Update on e1000 troubles (over-heating!)
Date: Sun, 6 Oct 2002 00:33:38 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I believe I have figured out why the e1000 crashed my machine 
> after .5 - 1 hours:  The NIC was over-heating.  I measured 
> one of the NICs after the machine crashed with an external 
> (cheap) temp probe.  It registered right at 50 degrees C, and 
> this was about 15-30 seconds after it crashed.

Ben, please send lspci -x on the hot nic.

-scott
