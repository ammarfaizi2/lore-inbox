Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263475AbTDWQUa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 12:20:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264107AbTDWQUa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 12:20:30 -0400
Received: from pop.gmx.net ([213.165.65.60]:60429 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263475AbTDWQU3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 12:20:29 -0400
Date: Wed, 23 Apr 2003 18:32:30 +0200
From: Marc Giger <gigerstyle@gmx.ch>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Bug 623] New: Volume not remembered.
Message-Id: <20030423183230.33a11a36.gigerstyle@gmx.ch>
In-Reply-To: <21660000.1051114998@[10.10.2.4]>
References: <21660000.1051114998@[10.10.2.4]>
X-Mailer: Sylpheed version 0.8.11claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

> Not certain if this is kernel or ALSA specific. In 2.4.x OSS volume levels
> were remembered for the various mixers. Now all of them always default to 0
> at bootup. I never ran ALSA with the 2.4 series, but it would be nice to
> remember volumes.
> Should I be bugging the alsa-project people instead?
> 
> Steps to reproduce:
> Set a volume level, reboot, level has been reset.

This is and was always so. The alsa-people provides the tool "alsactl"
to save and restore the soundcard settings..

greets

Marc
