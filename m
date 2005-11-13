Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750803AbVKMRdA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750803AbVKMRdA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Nov 2005 12:33:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751216AbVKMRdA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Nov 2005 12:33:00 -0500
Received: from pfepc.post.tele.dk ([195.41.46.237]:29071 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S1750803AbVKMRc7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Nov 2005 12:32:59 -0500
Date: Sun, 13 Nov 2005 18:34:35 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: hostap@shmoo.com, linux-kernel@vger.kernel.org, jgarzik@pobox.com,
       netdev@vger.kernel.org
Subject: Re: [2.6 patch] rename hostap.c to hostap_main.c
Message-ID: <20051113173435.GA12477@mars.ravnborg.org>
References: <20051106005343.GF3668@stusta.de> <20051106041543.GC8972@jm.kir.nu> <20051113162745.GM21448@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051113162745.GM21448@stusta.de>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> AFAIK you can't build a module hostap.o consisting of multiple objects 
> with the source files of one of them named hostap.c (Sam Cc'ed for this).

Correct.

	Sam
