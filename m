Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262807AbSLJRmY>; Tue, 10 Dec 2002 12:42:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262824AbSLJRmX>; Tue, 10 Dec 2002 12:42:23 -0500
Received: from donkeykong.gpcc.itd.umich.edu ([141.211.2.163]:25583 "EHLO
	donkeykong.gpcc.itd.umich.edu") by vger.kernel.org with ESMTP
	id <S262807AbSLJRmT>; Tue, 10 Dec 2002 12:42:19 -0500
Date: Tue, 10 Dec 2002 12:50:02 -0500 (EST)
From: Mohamed Amr Elayouty <melayout@umich.edu>
X-X-Sender: melayout@timepilot.gpcc.itd.umich.edu
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.51 won't boot with devfs enabled
Message-ID: <Pine.SOL.4.44.0212101246250.16436-100000@timepilot.gpcc.itd.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric I have a bug open on bugzilla for this.

The only workaround I know is by enabling CONFIG_UNIX98_PTYS=Y under
character devices.

Mohamed El Ayouty

