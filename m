Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265083AbUBOQPu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 11:15:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265100AbUBOQPu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 11:15:50 -0500
Received: from inova102.correio.tnext.com.br ([200.222.67.102]:8671 "HELO
	leia-auth.correio.tnext.com.br") by vger.kernel.org with SMTP
	id S265083AbUBOQPt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 11:15:49 -0500
X-Analyze: Velop Mail Shield v0.0.3
Date: Sun, 15 Feb 2004 13:15:42 -0300 (BRT)
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_L=2E_W=2E_Meunier?= <1@pervalidus.net>
To: Roman Jordan <RomanJordan@gmx.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: ALSA Sound and BT 878
In-Reply-To: <1076842492.3053.2.camel@darkstar>
Message-ID: <Pine.LNX.4.58.0402151314280.1090@pervalidus.dyndns.org>
References: <1076842492.3053.2.camel@darkstar>
X-Archive: encrypt
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Feb 2004, Roman Jordan wrote:

> i can't found a configuration entry for the bt878 sound device
> (television card) and the new ALSA architecture. Can i use ALSA and the
> bt 878 chip without OSS?

Download the latest ALSA or use some 2.6.3-rc. It has it
(CONFIG_SND_BT87X).

-- 
http://www.pervalidus.net/contact.html
