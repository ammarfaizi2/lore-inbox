Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262411AbUKWJhx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262411AbUKWJhx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 04:37:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262397AbUKWJhw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 04:37:52 -0500
Received: from nysv.org ([213.157.66.145]:26073 "EHLO nysv.org")
	by vger.kernel.org with ESMTP id S262411AbUKWJhn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 04:37:43 -0500
Date: Tue, 23 Nov 2004 11:37:30 +0200
To: Dirk Steinberg <dws@steinbergnet.net>
Cc: reiserfs-list@namesys.com, Hans Reiser <reiser@namesys.com>,
       Valdis.Kletnieks@vt.edu, Amit Gud <amitgud1@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: file as a directory
Message-ID: <20041123093730.GC26192@nysv.org>
References: <2c59f00304112205546349e88e@mail.gmail.com> <200411221759.iAMHx7QJ005491@turing-police.cc.vt.edu> <41A23566.6080903@namesys.com> <200411231011.21652.dws@steinbergnet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411231011.21652.dws@steinbergnet.net>
User-Agent: Mutt/1.5.6i
From: mjt@nysv.org (Markus  =?ISO-8859-1?Q?=20T=F6rnqvist?=)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2004 at 10:11:21AM +0100, Dirk Steinberg wrote:
>
>How about making metas a mount option? Right now disabling metas 
>requires patching the source.

Isn't there -o nopseudo already?

-- 
mjt

