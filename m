Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293574AbSBZLW1>; Tue, 26 Feb 2002 06:22:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292538AbSBZLWS>; Tue, 26 Feb 2002 06:22:18 -0500
Received: from mailer.zib.de ([130.73.108.11]:37779 "EHLO mailer.zib.de")
	by vger.kernel.org with ESMTP id <S292283AbSBZLWL>;
	Tue, 26 Feb 2002 06:22:11 -0500
Date: Tue, 26 Feb 2002 12:22:05 +0100
From: Sebastian Heidl <heidl@zib.de>
To: "David S. Miller" <davem@redhat.com>
Cc: nick@snowman.net, linux-kernel@vger.kernel.org, jgarzik@mandrakesoft.com,
        linux-net@vger.kernel.org
Subject: Re: [BETA] First test release of Tigon3 driver
Message-ID: <20020226122205.B8471@csr-pc6.local>
Mail-Followup-To: Sebastian Heidl <heidl@zib.de>,
	"David S. Miller" <davem@redhat.com>, nick@snowman.net,
	linux-kernel@vger.kernel.org, jgarzik@mandrakesoft.com,
	linux-net@vger.kernel.org
In-Reply-To: <20020225.165914.123908101.davem@redhat.com> <Pine.LNX.4.21.0202252243360.18586-100000@ns> <20020225.204022.62649663.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <20020225.204022.62649663.davem@redhat.com>; from davem@redhat.com on Mon, Feb 25, 2002 at 08:40:22PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2002 at 08:40:22PM -0800, David S. Miller wrote:
>    From: nick@snowman.net
>    Date: Mon, 25 Feb 2002 22:43:53 -0500 (EST)
> 
>    Can you list what cards/systems use this driver?  I at least am totally
>    unsure.
> 
> I can't tell you much more than the list of PCI device IDs and those
> are contained in the driver sources.
> 
> The first two cards I have for testing are 3COM copper gigabit cards
> but I have no idea what the official model numbers are for these as
> they came with no packaging.
I think these are 3C996-T. Is there any information about the compatibility of
TG3 to TG2 ?

_sh_

