Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318783AbSG0Qjq>; Sat, 27 Jul 2002 12:39:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318784AbSG0Qjq>; Sat, 27 Jul 2002 12:39:46 -0400
Received: from ns.purdue.org ([206.230.5.18]:41933 "EHLO ns")
	by vger.kernel.org with ESMTP id <S318783AbSG0Qjq>;
	Sat, 27 Jul 2002 12:39:46 -0400
Date: Sat, 27 Jul 2002 11:31:35 -0500
From: Kyler Laird <Kyler@Lairds.com>
To: linux-kernel@vger.kernel.org
Subject: Aironet driver still needs tqueue.h
Message-ID: <20020727163135.GL7753@jowls.lairds.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/net/aironet4500.h still needs
	#include <linux/tqueue.h>
in order to compile.

I've reported this multiple times.  Is there someone
else I need to tell?

Thank you.

--kyler

