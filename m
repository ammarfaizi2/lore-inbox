Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266899AbRGKXSg>; Wed, 11 Jul 2001 19:18:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266909AbRGKXS0>; Wed, 11 Jul 2001 19:18:26 -0400
Received: from pizda.ninka.net ([216.101.162.242]:51072 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S266899AbRGKXSY>;
	Wed, 11 Jul 2001 19:18:24 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15180.57019.834069.781908@pizda.ninka.net>
Date: Wed, 11 Jul 2001 16:18:19 -0700 (PDT)
To: David Chamness <chamness@PolyServe.com>
Cc: linux-kernel@vger.kernel.org, alan@redhat.com, torvalds@transmeta.com
Subject: Re: [PATCH] minor change to netsyms.c
In-Reply-To: <3B4C9492.7070201@PolyServe.com>
In-Reply-To: <3B4C9492.7070201@PolyServe.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


David Chamness writes:
 > I have written a module that needs both these symbols 
 > exported, and it would be much cleaner if they both were exported in a 
 > consistent manner.

I've applied your patch.

Later,
David S. Miller
davem@redhat.com
