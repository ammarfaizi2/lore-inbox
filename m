Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269237AbTGQTHJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 15:07:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270184AbTGQTHI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 15:07:08 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:8549 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S269237AbTGQTHH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 15:07:07 -0400
From: Alan Cox <alan@redhat.com>
Message-Id: <200307171920.h6HJKvU18756@devserv.devel.redhat.com>
Subject: Re: 2.6.0-test1-ac2: ac97_plugin_wm97xx.c doesn't compile non-modular
To: bunk@fs.tum.de (Adrian Bunk)
Date: Thu, 17 Jul 2003 15:20:57 -0400 (EDT)
Cc: alan@redhat.com (Alan Cox), liam.girdwood@wolfsonmicro.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20030717184046.GG1407@fs.tum.de> from "Adrian Bunk" at Gor 17, 2003 08:40:46 
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> ac97_plugin_wm97xx.c doesn't compile non-modular:

Missing linux/string.h perhaps ?
