Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266330AbSLOKtS>; Sun, 15 Dec 2002 05:49:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266335AbSLOKtS>; Sun, 15 Dec 2002 05:49:18 -0500
Received: from eos.telenet-ops.be ([195.130.132.40]:6889 "EHLO
	eos.telenet-ops.be") by vger.kernel.org with ESMTP
	id <S266330AbSLOKtR>; Sun, 15 Dec 2002 05:49:17 -0500
Date: Sun, 15 Dec 2002 11:57:06 +0100
From: Kurt Roeckx <Q@ping.be>
To: Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: adjtimex/ppskit
Message-ID: <20021215105706.GA20318@ping.be>
References: <20021207151404.A3627@ping.be> <3DF45D39.24443.3D7228@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DF45D39.24443.3D7228@localhost>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 09, 2002 at 09:07:35AM +0100, Ulrich Windl wrote:
> On 7 Dec 2002 at 15:14, Kurt Roeckx wrote:
> 
> the other 
> differences are because of the modified clock model and nanoseconds)

Is there a reason not to include the new clock model in the
kernel?

I'll make a patch based on the ppskit if needed.


Kurt

