Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261627AbULUVFj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261627AbULUVFj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 16:05:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261630AbULUVFj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 16:05:39 -0500
Received: from forte.mfa.kfki.hu ([148.6.72.11]:27534 "EHLO forte.mfa.kfki.hu")
	by vger.kernel.org with ESMTP id S261627AbULUVFf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 16:05:35 -0500
Date: Tue, 21 Dec 2004 22:05:34 +0100
From: Gergely Tamas <dice@mfa.kfki.hu>
To: Brad Fitzpatrick <brad@danga.com>
Cc: Chris Swanson <chrisjswanson@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Make changes to read-only file system using RAM
Message-ID: <20041221210534.GA2784@mfa.kfki.hu>
References: <1bdcbebf04122110087de9d976@mail.gmail.com> <Pine.LNX.4.58.0412211015030.17405@danga.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0412211015030.17405@danga.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

 > Check out unionfs.

Did you find a unionfs version for 2.6 ? As far as I see, version 1.0.3 [1]
is only for 2.4 .

For 2.6 one can try for example cowloop [2] (which works nice, btw).

[1] http://www.fsl.cs.sunysb.edu/project-unionfs.html
[2] www.atconsultancy.nl/cowloop

Gergely
