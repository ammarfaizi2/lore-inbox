Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318798AbSIPE4H>; Mon, 16 Sep 2002 00:56:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318802AbSIPE4H>; Mon, 16 Sep 2002 00:56:07 -0400
Received: from pizda.ninka.net ([216.101.162.242]:35551 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S318798AbSIPE4G>;
	Mon, 16 Sep 2002 00:56:06 -0400
Date: Sun, 15 Sep 2002 21:52:18 -0700 (PDT)
Message-Id: <20020915.215217.11271280.davem@redhat.com>
To: TheUnforgiven@attbi.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: To Anyone with a Radeon 7500 board and the ali developer
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020915203038.240b901a.TheUnforgiven@attbi.com>
References: <20020915203038.240b901a.TheUnforgiven@attbi.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Nicholas <TheUnforgiven@attbi.com>
   Date: Sun, 15 Sep 2002 20:30:38 -0400

   when i run glxgears (or any opengl) with my pc it locks hard when
   direct rendering is enabled.

Make sure the AGP mode being used by XFree86 matches the one
set by your BIOS.
