Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280822AbRKGPYK>; Wed, 7 Nov 2001 10:24:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280818AbRKGPX7>; Wed, 7 Nov 2001 10:23:59 -0500
Received: from node1500a.a2000.nl ([24.132.80.10]:61616 "HELO mail.alinoe.com")
	by vger.kernel.org with SMTP id <S280816AbRKGPXx>;
	Wed, 7 Nov 2001 10:23:53 -0500
Date: Wed, 7 Nov 2001 16:23:50 +0100
From: Carlo Wood <carlo@alinoe.com>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ircu-development] Slow on high-MTU (local host) connections?
Message-ID: <20011107162350.A22701@alinoe.com>
In-Reply-To: <20011107043425.A15045@alinoe.com> <20011106.195257.102576616.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011106.195257.102576616.davem@redhat.com>; from davem@redhat.com on Tue, Nov 06, 2001 at 07:52:57PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 06, 2001 at 07:52:57PM -0800, David S. Miller wrote:
> Repeat your experiment with nagle disabled on the sockets
> in question.

Thanks, I didn't try it yet - but I bet that will be it.
Sorry for the post to this list.

-- 
Carlo Wood <carlo@alinoe.com>
