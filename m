Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264661AbSJ3KoT>; Wed, 30 Oct 2002 05:44:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264657AbSJ3KoT>; Wed, 30 Oct 2002 05:44:19 -0500
Received: from dsl-linz6-150-193.utaonline.at ([62.218.150.193]:54256 "EHLO
	falke.mail") by vger.kernel.org with ESMTP id <S264661AbSJ3KoS>;
	Wed, 30 Oct 2002 05:44:18 -0500
Message-ID: <3DBFB84D.1CF55B2C@falke.mail>
Date: Wed, 30 Oct 2002 11:45:33 +0100
From: Thomas Winischhofer <thomas@winischhofer.net>
X-Mailer: Mozilla 4.76 [en] (Windows NT 5.0; U)
X-Accept-Language: en,en-GB,en-US,de-AT,de-DE,de-CH,sv
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Compile Error -- 2.4.20-rc1 -- SiSFB and DRM
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-MDRemoteIP: 10.0.0.13
X-Return-Path: thomas@winischhofer.net
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Stephane,

if you compile the SiS DRM module, you also need to select to compile
the SiS framebuffer driver. They depend on each other. 


Thomas

-- 
Thomas Winischhofer
Vienna/Austria                 
mailto:thomas@winischhofer.net            http://www.winischhofer.net/

