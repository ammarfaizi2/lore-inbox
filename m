Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261741AbVBXTSV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261741AbVBXTSV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 14:18:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262453AbVBXTSV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 14:18:21 -0500
Received: from hell.sks3.muni.cz ([147.251.210.30]:31933 "EHLO
	hell.sks3.muni.cz") by vger.kernel.org with ESMTP id S261741AbVBXTSM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 14:18:12 -0500
Date: Thu, 24 Feb 2005 20:18:09 +0100
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB 2.0 Mass storage device
Message-ID: <20050224191809.GB7978@mail.muni.cz>
References: <20050224175918.GA7627@mail.muni.cz> <20050224181347.GA10847@kroah.com> <20050224182300.GA7778@mail.muni.cz> <20050224184928.GA11490@kroah.com> <20050224190548.GA7978@mail.muni.cz> <20050224191243.GD11806@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050224191243.GD11806@kroah.com>
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, bomb
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2005 at 11:12:43AM -0800, Greg KH wrote:
> > When connected through uhci-hcd:
> > T:  Bus=04 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=12  MxCh= 0
> 
> Your device is only reporting that it can go at 12Mbit (full speed, not
> 480Mbit, which is high speed.)

Is this independent of used driver?

-- 
Luká¹ Hejtmánek
