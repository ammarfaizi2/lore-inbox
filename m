Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273108AbRIJAZB>; Sun, 9 Sep 2001 20:25:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273110AbRIJAYw>; Sun, 9 Sep 2001 20:24:52 -0400
Received: from [209.202.108.240] ([209.202.108.240]:38152 "EHLO
	terbidium.openservices.net") by vger.kernel.org with ESMTP
	id <S273108AbRIJAYp>; Sun, 9 Sep 2001 20:24:45 -0400
Date: Sun, 9 Sep 2001 20:24:47 -0400 (EDT)
From: Ignacio Vazquez-Abrams <ignacio@openservices.net>
To: <linux-kernel@vger.kernel.org>
Subject: Re: Lockup with 2.4.9-ac10 on Athlon
In-Reply-To: <Pine.LNX.4.33.0109091804450.1105-100000@terbidium.openservices.net>
Message-ID: <Pine.LNX.4.33.0109092023230.11787-100000@terbidium.openservices.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-scanner: scanned by Inflex 1.0.7 - (http://pldaniels.com/inflex/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Sep 2001, Ignacio Vazquez-Abrams wrote:

I have solved the problem. It had to do with the setting of
CONFIG_APM_REAL_MODE_POWER_OFF. It has to be on in my case.

Is there any time when this option _has_ to be off?

-- 
Ignacio Vazquez-Abrams  <ignacio@openservices.net>

