Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281340AbRKEU6D>; Mon, 5 Nov 2001 15:58:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281338AbRKEU5x>; Mon, 5 Nov 2001 15:57:53 -0500
Received: from quattro-eth.sventech.com ([205.252.89.20]:6151 "EHLO
	quattro.sventech.com") by vger.kernel.org with ESMTP
	id <S281335AbRKEU5p>; Mon, 5 Nov 2001 15:57:45 -0500
Date: Mon, 5 Nov 2001 16:04:25 -0500
From: Johannes Erdfelt <johannes@erdfelt.com>
To: Pavel Machek <pavel@suse.cz>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.14-pre6
Message-ID: <20011105160425.H20031@sventech.com>
In-Reply-To: <Pine.LNX.4.33.0110302349550.31996-100000@penguin.transmeta.com> <20011102120108.A47@toy.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011102120108.A47@toy.ucw.cz>; from pavel@suse.cz on Fri, Nov 02, 2001 at 12:01:08PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 02, 2001, Pavel Machek <pavel@suse.cz> wrote:
> > Oh, and the first funny patches for the upcoming SMT P4 cores are starting
> > to show up. More to come.
> 
> What is SMT P4?

Symmetric Multi Threading IIRC.

Essentially having a virtual dual CPU system on one die where you can
dispatch multiple programs to the differen execution units. For example
you can run a FP intensive program at the same time as an Integer
intensive program.

Nowhere close to true dual CPU performance because of resource
contention on the execution units, but better than single CPU
performance.

JE

