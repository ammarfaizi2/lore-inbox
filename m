Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261180AbVC3UiG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261180AbVC3UiG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 15:38:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261863AbVC3UiG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 15:38:06 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:50630 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261180AbVC3UiA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 15:38:00 -0500
Subject: Re: 2.6.11, IDE: Strange scheduling behaviour: high-pri RT process
	not scheduled?
From: Lee Revell <rlrevell@joe-job.com>
To: Mark Hahn <hahn@physics.mcmaster.ca>
Cc: kus Kusche Klaus <kus@keba.com>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0503300931350.7542-100000@coffee.psychology.mcmaster.ca>
References: <Pine.LNX.4.44.0503300931350.7542-100000@coffee.psychology.mcmaster.ca>
Content-Type: text/plain
Date: Wed, 30 Mar 2005 15:37:58 -0500
Message-Id: <1112215078.17365.11.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-03-30 at 09:41 -0500, Mark Hahn wrote:
> >> The test system runs a 2.6.11 kernel (no SMP) on a Pentium3 500 MHz 
> > embedded hardware.
> 
> which probably has memory bandwidth of at most a couple hundred MB/s,
> which is really horrible by modern standards.

What does that have to do with anything?  He said it was an embedded
system.

Lee

