Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283437AbRLDUWN>; Tue, 4 Dec 2001 15:22:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281450AbRLDUUf>; Tue, 4 Dec 2001 15:20:35 -0500
Received: from mailout05.sul.t-online.com ([194.25.134.82]:64407 "EHLO
	mailout05.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S283389AbRLDUTL>; Tue, 4 Dec 2001 15:19:11 -0500
Date: Tue, 4 Dec 2001 21:18:33 +0100
From: Gert Menke <gert@menke.za.net>
To: linux-kernel@vger.kernel.org
Subject: kapm-idled
Message-ID: <20011204211833.A1364@mouse.mydomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I just compiled 2.4.16 for my notebook with "Make CPU Idle calls when idle"
enabled. Now kapm-idled uses up to 50% cpu when the system is otherwise
idle. Is that correct? It is quite disturbing to have 50% System load when
the system is supposed to be idle.

Greetings
Gert
