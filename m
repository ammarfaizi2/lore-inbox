Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261401AbVBGMJK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261401AbVBGMJK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 07:09:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261404AbVBGMJK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 07:09:10 -0500
Received: from styx.suse.cz ([82.119.242.94]:11150 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S261401AbVBGMJG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 07:09:06 -0500
Date: Mon, 7 Feb 2005 13:09:58 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] twiddler compile fix.
Message-ID: <20050207120958.GA16865@ucw.cz>
References: <200502062207.49276.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200502062207.49276.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 06, 2005 at 10:07:48PM -0500, Dmitry Torokhov wrote:
> Hi,
> 
> Somehow this part of one of the earlier patches was lost...
> 
> -- 
> Dmitry
> 
> 
> ===================================================================
> 
> 
> ChangeSet@1.2122, 2005-02-06 20:25:21-05:00, dtor_core@ameritech.net
>   Input: fix compie error in twidjoy.c
>   
>   Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> 
> 
>  twidjoy.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletion(-)
> 
> 
> ===================================================================
 

Thanks; applied.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
