Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261385AbVCGBJg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261385AbVCGBJg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 20:09:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261386AbVCGBJg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 20:09:36 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:48618 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261385AbVCGBJR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 20:09:17 -0500
Subject: Re: 2.6.11 breaks ALSA Intel AC97 audio
From: Lee Revell <rlrevell@joe-job.com>
To: michael@ellerman.id.au
Cc: linux-kernel@vger.kernel.org, Lars <lhofhansl@yahoo.com>
In-Reply-To: <200503071109.08641.michael@ellerman.id.au>
References: <422A3C7F.3020501@yahoo.com>
	 <200503071109.08641.michael@ellerman.id.au>
Content-Type: text/plain
Date: Sun, 06 Mar 2005 20:09:16 -0500
Message-Id: <1110157756.29922.0.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-03-07 at 11:09 +1100, Michael Ellerman wrote:
> Hi Lars,
> 
> Yeah I've got no audio on my T41, which I think uses the AC97 too. I haven't 
> had time to look into it though :/
> 

Did you disable "Headphone Jack Sense" and "Line Jack Sense" in
alsamixer?

Lee

