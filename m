Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964927AbWEUTrM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964927AbWEUTrM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 15:47:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964930AbWEUTrM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 15:47:12 -0400
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:11735
	"EHLO bu3sch.de") by vger.kernel.org with ESMTP id S964927AbWEUTrL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 15:47:11 -0400
From: Michael Buesch <mb@bu3sch.de>
To: Pau Garcia i Quiles <pgquiles@elpauer.org>, linux-kernel@vger.kernel.org
Subject: Re: [IDEA] Poor man's UPS
Date: Sun, 21 May 2006 21:46:30 +0200
User-Agent: KMail/1.9.1
References: <200605212131.47860.pgquiles@elpauer.org> <20060521193803.GG8250@redhat.com>
In-Reply-To: <20060521193803.GG8250@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200605212146.30342.mb@bu3sch.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  > The "continuous hibernation" is some kind of memory snapshots taken, say, 
>  > every 5 minutes. The next time your system starts after a crash, it'd say "oh 

You really want a system, which freezes for 10-20 seconds every 5 minutes,
and thaws again when the image is written?
