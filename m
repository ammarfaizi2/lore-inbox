Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262522AbTIUTJD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 15:09:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262531AbTIUTJD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 15:09:03 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:28834 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S262522AbTIUTI6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 15:08:58 -0400
Date: Sun, 21 Sep 2003 21:08:35 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Peter Osterlund <petero2@telia.com>
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org,
       Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: [PATCH 1/2] synaptics: Don't try to handle more than eight multi buttons
Message-ID: <20030921190835.GB22194@ucw.cz>
References: <m2wuc2t148.fsf@p4.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m2wuc2t148.fsf@p4.localdomain>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 21, 2003 at 09:03:51PM +0200, Peter Osterlund wrote:
> This patch from Dmitry is not yet in Linus's tree. Please apply.
> Dmitry's original email was:
> 
> Peter,
> 
> Peter Berg Larsen pointed to me that with regard to multi-button 
> capabilities the spec says: "If nExtBtm is greater than 8 ... nExtbtm 
> should be considered to be invalid and treated as zero."
> 
> The patch below should fix that. I also sent it to Vojtech with my 
> reconnect patch.

Thanks, applied.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
