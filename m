Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261649AbVBOITK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261649AbVBOITK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 03:19:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261650AbVBOITK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 03:19:10 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:48316 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S261649AbVBOITI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 03:19:08 -0500
Date: Tue, 15 Feb 2005 09:15:32 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: a.hocquel@oreka.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: strange bug with realtek 8169 card
Message-ID: <20050215081532.GA23670@electric-eye.fr.zoreil.com>
References: <4210E7EA.3020301@oreka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4210E7EA.3020301@oreka.com>
User-Agent: Mutt/1.4.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexandre <a.hocquel_NOSPAM_@oreka.com> :
[...]
> Or any idea why the problem occurs and how to correct this (if it is 
> possbile)?

Upgrade the compiler if you use gcc 2.95.x.

--
Ueimor
