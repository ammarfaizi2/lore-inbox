Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262973AbVDLUgK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262973AbVDLUgK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 16:36:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262539AbVDLUfQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 16:35:16 -0400
Received: from [83.246.78.200] ([83.246.78.200]:58345 "EHLO
	srvh02.vc-server.de") by vger.kernel.org with ESMTP id S262556AbVDLS5q convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 14:57:46 -0400
Date: Tue, 12 Apr 2005 18:59:01 +0000
From: Dennis Heuer <dh@triple-media.com>
Subject: Re: 2.6.11.x: bootprompt: ALSA: no soundcard detected
To: linux-kernel@vger.kernel.org
References: <1113121569l.584l.0l@Foo>
	<2a4f155d05041002022788ae8b@mail.gmail.com> <1113128209l.588l.0l@Foo>
	<2a4f155d05041006096b203aed@mail.gmail.com> <1113165575l.556l.1l@Foo>
	<1113169605l.556l.6l@Foo>
In-Reply-To: <1113169605l.556l.6l@Foo> (from dh@triple-media.com on Sun Apr
	10 23:46:45 2005)
X-Mailer: Balsa 2.2.5
Message-Id: <1113332341l.588l.2l@Foo>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - srvh02.vc-server.de
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - triple-media.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's definetly ACPI! I played around with ACPI options in the BIOS and got my card working again. However, now reiserfs sometimes hangs and remembers this state so that I must check it from a live-cd. Linux 2.6 is definetly more sensible than 2.4.

Regards,
Dennis

