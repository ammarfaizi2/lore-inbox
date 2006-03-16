Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932689AbWCPTqV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932689AbWCPTqV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 14:46:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932693AbWCPTqV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 14:46:21 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:47501 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932689AbWCPTqU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 14:46:20 -0500
Date: Thu, 16 Mar 2006 20:46:09 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
cc: Eugene Teo <eugene.teo@eugeneteo.net>, linux-kernel@vger.kernel.org,
       perex@suse.cz
Subject: Re: Fix gus_pcm dereference before NULL
In-Reply-To: <20060315212459.74cc8b78.rdunlap@xenotime.net>
Message-ID: <Pine.LNX.4.61.0603162045440.11776@yvahk01.tjqt.qr>
References: <20060316020007.GA20734@eugeneteo.net> <20060315212459.74cc8b78.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>BTW, please use "-p" diff option so that the "@@" sections
>include function or struct names etc.  I.e., be nice to patch
>readers/reviewers.  :)
>
Talking of diff flags, how about adding -d? Does not cost too much.


Jan Engelhardt
-- 
