Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268332AbTBWK1K>; Sun, 23 Feb 2003 05:27:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268336AbTBWK1J>; Sun, 23 Feb 2003 05:27:09 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:22276 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S268332AbTBWK1I>; Sun, 23 Feb 2003 05:27:08 -0500
Date: Sun, 23 Feb 2003 10:37:17 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andi Kleen <ak@suse.de>
Cc: "David S. Miller" <davem@redhat.com>, hch@infradead.org, sim@netnation.com,
       linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: Longstanding networking / SMP issue? (duplextest)
Message-ID: <20030223103717.A16053@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andi Kleen <ak@suse.de>, "David S. Miller" <davem@redhat.com>,
	sim@netnation.com, linux-kernel@vger.kernel.org,
	linux-net@vger.kernel.org
References: <20030221104541.GA18417@wotan.suse.de> <20030223.011217.04700323.davem@redhat.com> <20030223100234.B15347@infradead.org> <20030223.015511.63413067.davem@redhat.com> <20030223103039.GA19725@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030223103039.GA19725@wotan.suse.de>; from ak@suse.de on Sun, Feb 23, 2003 at 11:30:39AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 23, 2003 at 11:30:39AM +0100, Andi Kleen wrote:
> > My bad.  Thanks for spotting this.
> 
> Won't work if the IPv4 code is ever made modular.

I think Rusty is working on making it working for modules.  Anyway I think
that would be one of the minor problem when making ipv4 modular :)

