Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280717AbRKBO55>; Fri, 2 Nov 2001 09:57:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280714AbRKBO5s>; Fri, 2 Nov 2001 09:57:48 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:805 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S280712AbRKBO5b>; Fri, 2 Nov 2001 09:57:31 -0500
Date: Fri, 2 Nov 2001 09:57:27 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Paul Fulghum <paulkf@microgate.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: emu10k emits buzzing and crackling
Message-ID: <20011102095727.D3662@redhat.com>
In-Reply-To: <20011101200955.A1913@redhat.com> <3BE25511.3080708@zianet.com> <004f01c163ad$ef8705a0$0c00a8c0@diemos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <004f01c163ad$ef8705a0$0c00a8c0@diemos>; from paulkf@microgate.com on Fri, Nov 02, 2001 at 08:52:03AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 02, 2001 at 08:52:03AM -0600, Paul Fulghum wrote:
> I'm seeing something similar on RH7.2 with the emu10K driver.
> Except XMMS and the cd player result in nothing but noise, but
> the window manager events sound fine. The volume of noise
> from XMMS/CD player can be controlled by the mixer.

That's very interesting as the driver shipped with rh7.2 works fine on 
my card.  Are they different revisions of the card?  Could you post your 
startup logs for the driver -- perhaps we can find some pattern to this 
and make some kind of quirks mapping.

		-ben
-- 
Fish.
