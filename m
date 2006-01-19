Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422633AbWASU3U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422633AbWASU3U (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 15:29:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161417AbWASU3U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 15:29:20 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:44929 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1161416AbWASU3T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 15:29:19 -0500
Date: Thu, 19 Jan 2006 21:28:48 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Sam Ravnborg <sam@ravnborg.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] kconfig: fix /dev/null breakage
In-Reply-To: <20060119200418.GB3557@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.61.0601192128141.26558@yvahk01.tjqt.qr>
References: <20060119200216.GA3557@mars.ravnborg.org> <20060119200418.GB3557@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Following patch implements a suggestion
>from Bryan O'Sullivan <bos@serpentine.com> to
>use gcc -print-file-name=libxxx.so.

Just for completeness: Does it work with all gccs supported?



Jan Engelhardt
-- 
