Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261758AbVASPsD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261758AbVASPsD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 10:48:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261759AbVASPsD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 10:48:03 -0500
Received: from styx.suse.cz ([82.119.242.94]:29655 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S261758AbVASPrm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 10:47:42 -0500
Date: Wed, 19 Jan 2005 16:49:46 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Hannes Reinecke <hare@suse.de>
Cc: dtor_core@ameritech.net, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] Remove input_call_hotplug
Message-ID: <20050119154946.GA8839@ucw.cz>
References: <41ED2457.1030109@suse.de> <d120d50005011807566ee35b2b@mail.gmail.com> <41EE2F82.3080401@suse.de> <d120d500050119060530b57cd7@mail.gmail.com> <41EE6BA8.6020705@suse.de> <d120d500050119064461d21d80@mail.gmail.com> <41EE7521.1010900@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41EE7521.1010900@suse.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2005 at 03:56:33PM +0100, Hannes Reinecke wrote:

> oops. hadn't thought of that. But of course, you are correct.
> So better be using monotonically increasing numbers.
> 
> New patch attached.

This one looks quite OK to me.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
