Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422631AbWASUWS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422631AbWASUWS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 15:22:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422632AbWASUWS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 15:22:18 -0500
Received: from 200-170-96-180.veloxmail.com.br ([200.170.96.180]:30091 "EHLO
	niobe-out.veloxmail.com.br") by vger.kernel.org with ESMTP
	id S1422631AbWASUWR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 15:22:17 -0500
X-Authenticated-User: fredlwm@veloxmail.com.br
X-Authenticated-User: fredlwm@veloxmail.com.br
Date: Thu, 19 Jan 2006 18:22:12 -0200 (BRST)
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_L=2E_W=2E_Meunier?= <2@pervalidus.net>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RFC: OSS driver removal, a slightly different approach
In-Reply-To: <20060119194432.GX19398@stusta.de>
Message-ID: <Pine.LNX.4.64.0601191815550.1300@dyndns.pervalidus.net>
References: <20060119174600.GT19398@stusta.de> <1137694944.32195.1.camel@mindpipe>
 <20060119182859.GW19398@stusta.de> <1137695945.32195.7.camel@mindpipe>
 <20060119194432.GX19398@stusta.de>
X-Archive: encrypt
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Jan 2006, Adrian Bunk wrote:

> 3. no ALSA drivers for the same hardware

Why aren't drivers like SOUND_TVMIXER listed ? That one isn't 
in ALSA, but there's a port at 
http://www.gilfillan.org/v3tv/ALSA/ . It's now the only I 
enable in OSS.

-- 
How to contact me - http://www.pervalidus.net/contact.html
