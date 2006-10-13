Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932101AbWJNFgs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932101AbWJNFgs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 01:36:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932103AbWJNFgs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 01:36:48 -0400
Received: from mail.kroah.org ([69.55.234.183]:40387 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932101AbWJNFgr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 01:36:47 -0400
Date: Fri, 13 Oct 2006 11:48:34 -0700
From: Greg KH <greg@kroah.com>
To: Michael Krufky <mkrufky@linuxtv.org>
Cc: Greg KH <gregkh@suse.de>,
       v4l-dvb maintainer list <v4l-dvb-maintainer@linuxtv.org>,
       linux-kernel@vger.kernel.org, stable@kernel.org
Subject: Re: [stable] [patch 06/67] Video: cx24123: fix PLL divisor setup
Message-ID: <20061013184834.GA22502@kroah.com>
References: <20061011204756.642936754@quad.kroah.org> <20061011210353.GG16627@kroah.com> <452D5EF7.80303@linuxtv.org> <20061011212959.GA18006@suse.de> <452D63D4.6050300@linuxtv.org> <20061011230125.GB26135@kroah.com> <452D853B.7010000@linuxtv.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <452D853B.7010000@linuxtv.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2006 at 07:58:51PM -0400, Michael Krufky wrote:
> The 2.6.18.y queue is fine now. As for the 2.6.17.y queue, it should read as follows:
> 
> DVB: cx24123: fix PLL divisor setup
> V4L: Fix msp343xG handling regression
> 
> The msp343xG patch needs to be changed from DVB to V4L.

Ok, fixed now.

thanks,

greg k-h
