Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293459AbSCEQxA>; Tue, 5 Mar 2002 11:53:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293483AbSCEQwu>; Tue, 5 Mar 2002 11:52:50 -0500
Received: from mailer.zib.de ([130.73.108.11]:59084 "EHLO mailer.zib.de")
	by vger.kernel.org with ESMTP id <S293459AbSCEQwj>;
	Tue, 5 Mar 2002 11:52:39 -0500
Date: Tue, 5 Mar 2002 17:52:33 +0100
From: Sebastian Heidl <heidl@zib.de>
To: Scott Laird <laird@internap.com>
Cc: Thomas =?iso-8859-1?Q?Lang=E5s?= <tlan@stud.ntnu.no>,
        linux-kernel@vger.kernel.org, "David S. Miller" <davem@redhat.com>,
        jgarzik@mandrakesoft.com, linux-net@vger.kernel.org
Subject: Re: [BETA-0.95] Sixth test release of Tigon3 driver
Message-ID: <20020305175233.M8471@csr-pc6.local>
Mail-Followup-To: Sebastian Heidl <heidl@zib.de>,
	Scott Laird <laird@internap.com>,
	Thomas =?iso-8859-1?Q?Lang=E5s?= <tlan@stud.ntnu.no>,
	linux-kernel@vger.kernel.org, "David S. Miller" <davem@redhat.com>,
	jgarzik@mandrakesoft.com, linux-net@vger.kernel.org
In-Reply-To: <20020305.055204.44939648.davem@redhat.com> <20020305150204.A7174@stud.ntnu.no> <20020305.060323.99455532.davem@redhat.com> <20020305.060604.68157839.davem@redhat.com> <20020305153025.A12473@stud.ntnu.no> <2532693.1015317048@[0.0.0.0]>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.16i
In-Reply-To: <2532693.1015317048@[0.0.0.0]>; from laird@internap.com on Tue, Mar 05, 2002 at 08:30:48AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 05, 2002 at 08:30:48AM -0800, Scott Laird wrote:
> --On Tuesday, March 5, 2002 3:30 PM +0100 Thomas Langås 
> <tlan@stud.ntnu.no> wrote:
> 
> > David S. Miller:
> >> Most gigabit switches don't support 9000 byte mtu :-)
> >
> > Hmm, I found a document through google; Cisco Catalyst 4006 doesn't
> > support 9KB MTUs, so I'll contact the networking guys and fix this,
> > we want switches that supports large MTUs :)
> 
> Good luck; they're fairly rare.

just an add-on:
NortelNetworks http://www.nortelnetworks.com sells Alteon Switches which are
Jumbo-capable. I'm sure the're also available elsewhere. Don't know about the
price though...

_sh_

