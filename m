Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318260AbSGQJS3>; Wed, 17 Jul 2002 05:18:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318258AbSGQJS2>; Wed, 17 Jul 2002 05:18:28 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:64162 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S318261AbSGQJS1>;
	Wed, 17 Jul 2002 05:18:27 -0400
Date: Wed, 17 Jul 2002 11:21:19 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.x linux/input.h:KEY_{PLAY,FASTFORWARD}
Message-ID: <20020717112119.A12012@ucw.cz>
References: <20020716.175648.101482617.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020716.175648.101482617.davem@redhat.com>; from davem@redhat.com on Tue, Jul 16, 2002 at 05:56:48PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 16, 2002 at 05:56:48PM -0700, David S. Miller wrote:
> 
> Why are they defined twice to two different values?

It's a stupid bug. I already fixed that, but it didn't make it into
2.5.26.

-- 
Vojtech Pavlik
SuSE Labs
