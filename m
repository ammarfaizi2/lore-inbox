Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129921AbRBRX6M>; Sun, 18 Feb 2001 18:58:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129562AbRBRX6B>; Sun, 18 Feb 2001 18:58:01 -0500
Received: from quattro.sventech.com ([205.252.248.110]:37124 "HELO
	quattro.sventech.com") by vger.kernel.org with SMTP
	id <S129313AbRBRX5t>; Sun, 18 Feb 2001 18:57:49 -0500
Date: Sun, 18 Feb 2001 18:57:48 -0500
From: Johannes Erdfelt <johannes@erdfelt.com>
To: lafanga lafanga <lafanga1@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Proliant hangs with 2.4 but works with 2.2.
Message-ID: <20010218185748.A28687@sventech.com>
In-Reply-To: <F91i3lDraH8kvLMxLQn00012fe9@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4i
In-Reply-To: <F91i3lDraH8kvLMxLQn00012fe9@hotmail.com>; from lafanga lafanga on Sun, Feb 18, 2001 at 11:08:11PM -0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 18, 2001, lafanga lafanga <lafanga1@hotmail.com> wrote:
> The programs 'gpm', 'kudzu' and 'startx' all hang the server immediately 
> after they exit (with exit status 0). I cannot pinpoint why the kernel hangs 
> and would appreciate any help. The only thing I suspect it may be is that it 
> is a dual processor mobo with only one processor but I don't know how this 
> detection has changed in the 2.4 kernels.

I bet you it has to do with the PS/2 port. Do you have a mouse plugged
in?

Does the 1600 use a Serverworks chipset?

JE

