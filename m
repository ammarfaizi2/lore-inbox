Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932357AbWCMIRv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932357AbWCMIRv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 03:17:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932358AbWCMIRu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 03:17:50 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:32189 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932357AbWCMIRu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 03:17:50 -0500
Subject: Re: Which kernel is the best for a small linux system?
From: Arjan van de Ven <arjan@infradead.org>
To: j4K3xBl4sT3r <jakexblaster@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <436c596f0603121640h4f286d53h9f1dd177fd0475a4@mail.gmail.com>
References: <436c596f0603121640h4f286d53h9f1dd177fd0475a4@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 13 Mar 2006 09:17:47 +0100
Message-Id: <1142237867.3023.8.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-03-12 at 21:40 -0300, j4K3xBl4sT3r wrote:
> Hello all,
> 
> I've been seeing many Linux versions, with many features, some of them
> just for the newest branches (2.4.x and 2.6.x), I would like to know
> for which kind of system each kernel is recommended. On the distros
> that we see inside the Net there is the 2.4.x series, normally I
> update to 2.6.x (in case of my Slackware 10.2, even getting problems
> with some devices). Is that floppy disks uses only 2.0.x and 2.2.x
> Kernels? If applicable, where can I get (detailed) information about
> these issues? I'm new on Kernel managing, started doing my own distros
> at less than one month and would like to know it.

regardless of the size issue; you should really not start any new
projects based on 2.4 kernels; they are in deep deep maintenance mode
for now, but it's unclear how long they will be (I suppose as long as
people keep sending patches), especially complex security issues should
worry people ;)

2.6 is actively maintained and will be for quite some time :)

