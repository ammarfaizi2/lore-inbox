Return-Path: <linux-kernel-owner+w=401wt.eu-S1751457AbXAGSVx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751457AbXAGSVx (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 13:21:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751458AbXAGSVx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 13:21:53 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:42264 "HELO
	viper.oldcity.dca.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751457AbXAGSVx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 13:21:53 -0500
Subject: Re: 2.6.20-rc3 regression: suspend to RAM broken on Mac mini Core
	Duo
From: Lee Revell <rlrevell@joe-job.com>
To: Tino Keitel <tino.keitel@tikei.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20070107151744.GA9799@dose.home.local>
References: <20070107151744.GA9799@dose.home.local>
Content-Type: text/plain
Date: Sun, 07 Jan 2007 13:23:13 -0500
Message-Id: <1168194194.18788.63.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2007-01-07 at 16:17 +0100, Tino Keitel wrote:
> No information about the device/driver that refuses to resume.

You should be able to identify the problematic driver by removing each
driver manually before suspending.

Lee

