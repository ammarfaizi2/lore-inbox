Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262450AbVBXS16@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262450AbVBXS16 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 13:27:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262454AbVBXS1n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 13:27:43 -0500
Received: from hell.sks3.muni.cz ([147.251.210.30]:26753 "EHLO
	hell.sks3.muni.cz") by vger.kernel.org with ESMTP id S262354AbVBXS0R
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 13:26:17 -0500
Date: Thu, 24 Feb 2005 19:26:13 +0100
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: Matthias-Christian Ott <matthias.christian@tiscali.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB 2.0 Mass storage device
Message-ID: <20050224182613.GB7778@mail.muni.cz>
References: <20050224175918.GA7627@mail.muni.cz> <421E1BB1.4090303@tiscali.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <421E1BB1.4090303@tiscali.de>
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, bomb
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2005 at 07:23:45PM +0100, Matthias-Christian Ott wrote:
> Is hotplug enabled (it should detect it as a scsi generic mass storage)?

No, I detect device loading proper modules. With uhci-hcd it works perfectly
except the speed. ehci-hcd does not detect it at all.

-- 
Luká¹ Hejtmánek
