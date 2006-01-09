Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750826AbWAICqL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750826AbWAICqL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 21:46:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750827AbWAICqL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 21:46:11 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:38804 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1750826AbWAICqK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 21:46:10 -0500
Subject: Re: Why is 2.4.32 four times faster than 2.6.14.6??
From: Lee Revell <rlrevell@joe-job.com>
To: Jesse Brandeburg <jesse.brandeburg@gmail.com>
Cc: gcoady@gmail.com, Bernd Eckenfels <be-news06@lina.inka.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <4807377b0601081837u2c1d50b3w218d5ef9e3dc662@mail.gmail.com>
References: <20060108095741.GH7142@w.ods.org>
	 <E1EvXi5-0000kv-00@calista.inka.de>
	 <igs1s1lje7b7kkbmb9t6d06n8425i1b1i4@4ax.com>
	 <4807377b0601081837u2c1d50b3w218d5ef9e3dc662@mail.gmail.com>
Content-Type: text/plain
Date: Sun, 08 Jan 2006 21:46:07 -0500
Message-Id: <1136774768.2997.8.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-01-08 at 18:37 -0800, Jesse Brandeburg wrote:
> Also, what do you have HZ set to? (250 is default in 2.6, 1000 in 2.4)
> so you could try running your 2.6 kernel with HZ=1000 

s/1000/100/

