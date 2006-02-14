Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422745AbWBNSNw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422745AbWBNSNw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 13:13:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422741AbWBNSNw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 13:13:52 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:34980 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1422745AbWBNSNv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 13:13:51 -0500
Date: Tue, 14 Feb 2006 19:12:29 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Adrian Bunk <bunk@stusta.de>
cc: sfrench@samba.org, linux-cifs-client@lists.samba.org,
       samba-technical@lists.samba.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc: CIFS reproducibly freezes the computer
In-Reply-To: <20060214135016.GC10701@stusta.de>
Message-ID: <Pine.LNX.4.61.0602141911470.32490@yvahk01.tjqt.qr>
References: <20060214135016.GC10701@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>"Complete freeze" is:
>[..]
>  is played in an endless loop by the sound chip

Sounds like a portion of code disabled interrupts?



Jan Engelhardt
-- 
