Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932538AbVLMHdp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932538AbVLMHdp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 02:33:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932530AbVLMHdo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 02:33:44 -0500
Received: from mail.kroah.org ([69.55.234.183]:54751 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932537AbVLMHd1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 02:33:27 -0500
Date: Mon, 12 Dec 2005 23:32:30 -0800
From: Greg KH <greg@kroah.com>
To: mchehab@brturbo.com.br
Cc: akpm@osdl.org, js@linuxtv.org, linux-kernel@vger.kernel.org,
       mchehab@infradead.org, linux-dvb-maintainer@linuxtv.org,
       stable@kernel.org, Ricardo Cerqueira <v4l@cerqueira.org>
Subject: Re: [stable] [PATCH 5/7] V4L/DVB (3135) Fix tuner init for Pinnacle PCTV Stereo
Message-ID: <20051213073230.GF5056@kroah.com>
References: <1134083966.7047.160.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1134083966.7047.160.camel@localhost>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 08, 2005 at 09:18:47PM -0200, mchehab@brturbo.com.br wrote:
> From: Ricardo Cerqueira <v4l@cerqueira.org>
> 
> - The Pinnacle PCTV Stereo needs tda9887 port2 set to 1
> - Without this patch, mt20xx tuner is not detected and the board
>   doesn't tune.
> 
> Signed-off-by: Ricardo Cerqueira <v4l@cerqueira.org>
> Signed-off-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>

queued to -stable, thanks.

greg k-h

