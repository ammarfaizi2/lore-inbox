Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261278AbVCYCkm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261278AbVCYCkm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 21:40:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261321AbVCYCkm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 21:40:42 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:13969 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261278AbVCYCki (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 21:40:38 -0500
Subject: Re: How's the nforce4 support in Linux?
From: Lee Revell <rlrevell@joe-job.com>
To: Robert Hancock <hancockr@shaw.ca>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <4243743D.8070404@shaw.ca>
References: <3LwFC-4Ko-15@gated-at.bofh.it>  <4243743D.8070404@shaw.ca>
Content-Type: text/plain
Date: Thu, 24 Mar 2005 21:40:34 -0500
Message-Id: <1111718434.9303.4.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-03-24 at 20:15 -0600, Robert Hancock wrote:
> There is no need to use any binary drivers on the nForce4 - the only 
> ones even available are for the network and audio. The network works 
> fine with the forcedeth driver included in the kernel - I don't know 
> about the audio, I'm not using the onboard sound.

Your statement is self contradictory.  How can you say there's no need
to use binary drivers if you don't know anything about the audio
support?  Many users consider sound a critical feature.

As a matter of fact there are a few quirks with the audio on Nvidia
chipsets, due to (surprise) lack of documentation.

Lee

