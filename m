Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262778AbTC0Bl5>; Wed, 26 Mar 2003 20:41:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262780AbTC0Bl5>; Wed, 26 Mar 2003 20:41:57 -0500
Received: from quattro.sventech.com ([205.252.248.110]:20968 "EHLO
	quattro.sventech.com") by vger.kernel.org with ESMTP
	id <S262778AbTC0Bl4>; Wed, 26 Mar 2003 20:41:56 -0500
Date: Wed, 26 Mar 2003 20:53:09 -0500
From: Johannes Erdfelt <johannes@erdfelt.com>
To: Max Krasnyansky <maxk@qualcomm.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: [BK] Bluetooth updates for 2.4.21-pre6
Message-ID: <20030326205309.A9855@sventech.com>
References: <Pine.LNX.4.53L.0303262107480.2544@freak.distro.conectiva> <5.1.0.14.2.20030326174507.05351f98@unixmail.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <5.1.0.14.2.20030326174507.05351f98@unixmail.qualcomm.com>; from maxk@qualcomm.com on Wed, Mar 26, 2003 at 05:50:41PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 26, 2003, Max Krasnyansky <maxk@qualcomm.com> wrote:
> <maxk@qualcomm.com> (03/03/19 1.1106)
>    [Bluetooth]
>    Do not submit more than one usb bulk rx request. It crashes uhci.o driver.

I don't recall seeing an email about this.

uhci.o should handle this situation correctly.

JE

