Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271341AbTHDAVR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 20:21:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271356AbTHDAVR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 20:21:17 -0400
Received: from smtp.terra.es ([213.4.129.129]:59087 "EHLO tsmtp10.mail.isp")
	by vger.kernel.org with ESMTP id S271341AbTHDAVQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 20:21:16 -0400
Date: Mon, 4 Aug 2003 02:21:01 +0200
From: Diego Calleja =?ISO-8859-15?Q?Garc=EDa?= <diegocg@teleline.es>
To: Russell Whitaker <russ@ashlandhome.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test2-bk3
Message-Id: <20030804022101.688a1c68.diegocg@teleline.es>
In-Reply-To: <Pine.LNX.4.53.0308031641270.127@bigred.russwhit.org>
References: <Pine.LNX.4.53.0308031641270.127@bigred.russwhit.org>
X-Mailer: Sylpheed version 0.9.3 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Sun, 3 Aug 2003 16:45:31 -0700 (PDT) Russell Whitaker <russ@ashlandhome.net> escribió:

> Hi
> 
> Durring boot I get:
> 
>   modprobe: QM_MODULES: function not implemented

Have you installed the latest module-init-tools?
(new module tools needed for 2.6 kernels documented in Documentation/Changes)
