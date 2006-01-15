Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932112AbWAOSJt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932112AbWAOSJt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 13:09:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932118AbWAOSJt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 13:09:49 -0500
Received: from tirith.ics.muni.cz ([147.251.4.36]:13954 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S932112AbWAOSJs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 13:09:48 -0500
From: "Jiri Slaby" <xslaby@fi.muni.cz>
Date: Sun, 15 Jan 2006 19:09:45 +0100
To: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: [SOLVED] Re: Synclient (synaptics driver) broken since 2.6.15-rc1 (shm related)
Cc: linux-kernel@vger.kernel.org
References: <20060115170502.6012822AEF3@anxur.fi.muni.cz>
In-reply-to: <200601151251.45488.dtor_core@ameritech.net>
Message-Id: <20060115180944.2F75722AEF3@anxur.fi.muni.cz>
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Envelope-From: xslaby@fi.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov wrote:
>Did Synaptics driver initialized successfully? IOW do you have
>/dev/input/eventX nodes? IOW have you upgraded udev?
Shame on me, I thought that I've updated, but actually I haven't, I had udev-58.

thanks,
--
Jiri Slaby         www.fi.muni.cz/~xslaby
~\-/~      jirislaby@gmail.com      ~\-/~
B67499670407CE62ACC8 22A032CC55C339D47A7E
