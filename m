Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262706AbTCPR4S>; Sun, 16 Mar 2003 12:56:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262708AbTCPR4S>; Sun, 16 Mar 2003 12:56:18 -0500
Received: from smtp.terra.es ([213.4.129.129]:26457 "EHLO tsmtp1.mail.isp")
	by vger.kernel.org with ESMTP id <S262706AbTCPR4S>;
	Sun, 16 Mar 2003 12:56:18 -0500
Date: Sun, 16 Mar 2003 18:48:23 +0100
From: Arador <diegocg@teleline.es>
To: Maxime <x@organigramme.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: make bzImage fails when LANG set
Message-Id: <20030316184823.08778fbf.diegocg@teleline.es>
In-Reply-To: <3E74AC1C.8010901@organigramme.net>
References: <3E74AC1C.8010901@organigramme.net>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Mar 2003 11:53:48 -0500
Maxime <x@organigramme.net> wrote:


> export LANG=fr
> export LC_ALL=fr_CA
> 
> By removing them, the kernel compiled just fine.  Stange bug!

It works with es_ES@euro (debian sid environment, gcc 3.2.3)
