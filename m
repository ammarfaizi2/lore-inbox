Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317860AbSGPObp>; Tue, 16 Jul 2002 10:31:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317859AbSGPOb2>; Tue, 16 Jul 2002 10:31:28 -0400
Received: from ns1.alcove-solutions.com ([212.155.209.139]:62171 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S317857AbSGPObZ>; Tue, 16 Jul 2002 10:31:25 -0400
Date: Tue, 16 Jul 2002 16:34:15 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: input subsystem config ?
Message-ID: <20020716143415.GO7955@tahoe.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mail-Followup-To: Stelian Pop <stelian.pop@fr.alcove.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have problems with the input subsystem in the latest BK tree,
on a Sony Vaio laptop (regular keyboard, integrated PS/2 trackball):
the keyboard works but the mouse is never initialized (nothing in 
the logs, AUX irq not reserved etc).

Before I submit a proper bug report, could someone confirm that
the input susbystem is supposed to be working now and what
config should I use (I tried several config options, all input
items 'Y', or some items compiled as modules etc).

Thanks,

Stelian.
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
