Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030322AbVIOBUm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030322AbVIOBUm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 21:20:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030323AbVIOBUl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 21:20:41 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:9966 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1030322AbVIOBUl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 21:20:41 -0400
Subject: Re: HZ question
From: Lee Revell <rlrevell@joe-job.com>
To: coywolf@gmail.com
Cc: markh@compro.net, linux-kernel@vger.kernel.org
In-Reply-To: <2cd57c9005091321006825540@mail.gmail.com>
References: <4326CAB3.6020109@compro.net>
	 <2cd57c9005091321006825540@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 14 Sep 2005 21:20:36 -0400
Message-Id: <1126747237.13893.108.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-09-14 at 12:00 +0800, Coywolf Qi Hunt wrote:
> simply zgrep HZ= /proc/config.gz
> on my box, I get CONFIG_HZ=1000

Many distros inexplicably disable that by default.

Lee

