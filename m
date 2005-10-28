Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965081AbVJ1D4H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965081AbVJ1D4H (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 23:56:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965082AbVJ1D4H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 23:56:07 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:30913 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S965081AbVJ1D4G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 23:56:06 -0400
Subject: Re: Overruns are killing my recordings.
From: Lee Revell <rlrevell@joe-job.com>
To: Avuton Olrich <avuton@gmail.com>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <3aa654a40510271700l49fb06cfv37d8b6030df5ac49@mail.gmail.com>
References: <3aa654a40510271212j13e0843s9de81c02f4e766ac@mail.gmail.com>
	 <200510271528.28919.diablod3@gmail.com>
	 <3aa654a40510271257t62d2fd82n5f2bcbcae2bcba9d@mail.gmail.com>
	 <1130447216.19492.87.camel@mindpipe>
	 <3aa654a40510271700l49fb06cfv37d8b6030df5ac49@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 27 Oct 2005 23:40:51 -0400
Message-Id: <1130470852.4363.26.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-10-27 at 17:00 -0700, Avuton Olrich wrote:
> aggh. Sorry for all the noise,
> 
> I have all my drives on a linear raid and I had hdparm set to put my
> IDE drives to sleep after a while, I didn't put it together because it
> was happening in the middle of recording.

Hey, I think it's a testament to the progress that has been made in the
past year and a half that people now consider audio dropouts in a "known
good" app like ecasound to be a kernel bug.  For the longest time the
answer was "linux isn't an RTOS, deal with it".

Lee

