Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262445AbULOSsa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262445AbULOSsa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 13:48:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262446AbULOSsa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 13:48:30 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:47779 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262445AbULOSs2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 13:48:28 -0500
Subject: Re: Issue on connect 2 modems with a single phone line
From: Lee Revell <rlrevell@joe-job.com>
To: Park Lee <parklee_sel@yahoo.com>
Cc: dave@lafn.org, linux-kernel@vger.kernel.org
In-Reply-To: <20041215184206.43601.qmail@web51505.mail.yahoo.com>
References: <20041215184206.43601.qmail@web51505.mail.yahoo.com>
Content-Type: text/plain
Date: Wed, 15 Dec 2004 13:48:26 -0500
Message-Id: <1103136506.18982.73.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-12-15 at 10:42 -0800, Park Lee wrote:
> Hi,
>   I want to try serial console in order to see the
> complete Linux kernel oops. 
>   I have 2 computers, one is a PC, and the other is a
> Laptop. Unfortunately,my Laptop doesn't have a serial
> port on it.

No idea but it would be way easier to use netconsole.  That is, unless
the oops happens before the network is up.

Lee

