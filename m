Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264494AbTLEWrz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 17:47:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264548AbTLEWrz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 17:47:55 -0500
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:58578 "EHLO
	mta4.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id S264494AbTLEWrx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 17:47:53 -0500
Date: Fri, 5 Dec 2003 14:45:29 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Erik Andersen <andersen@codepoet.org>,
       Torsten Scheck <torsten.scheck@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: Large-FAT32-Filesystem Bug
Message-ID: <20031205224529.GS29119@mis-mike-wstn.matchmail.com>
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Torsten Scheck <torsten.scheck@gmx.de>,
	linux-kernel@vger.kernel.org
References: <3FD0555F.5060608@gmx.de> <20031205160746.GA18568@codepoet.org> <3FD0C64D.5050804@gmx.de> <20031205221051.GA3244@codepoet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031205221051.GA3244@codepoet.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 05, 2003 at 03:10:51PM -0700, Erik Andersen wrote:
> No problem.  I put this patch together quite a while ago for
> my own use and never got around to sending it in.  It removes
> a number of artificial fat32 limits, and allows files up to 4GB,

Why only 4gb?
