Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261337AbTAIBxm>; Wed, 8 Jan 2003 20:53:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261338AbTAIBxm>; Wed, 8 Jan 2003 20:53:42 -0500
Received: from [213.228.128.91] ([213.228.128.91]:2451 "HELO
	front3.netvisao.pt") by vger.kernel.org with SMTP
	id <S261337AbTAIBxl>; Wed, 8 Jan 2003 20:53:41 -0500
Subject: Re: Linux 2.4.21pre3-ac2
From: "Paulo Andre'" <fscked@netvisao.pt>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200301090139.h091d9G26412@devserv.devel.redhat.com>
References: <200301090139.h091d9G26412@devserv.devel.redhat.com>
Content-Type: text/plain
Organization: Corleone Hacking Corp.
Message-Id: <1042077739.28495.16.camel@nostromo.orion.int>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 09 Jan 2003 02:02:20 +0000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-01-09 at 01:39, Alan Cox wrote:
> The skb_padto bug is quite ugly so people really want to be using ac2 not
> ac1. 

Considering you seem to have revived 2.4-ac, would you be interested in collecting
various bugixes wrt cli/save_flags/restore_flags or is that better off in 2.5?
(or maybe it doesn't even really matter?)

--
	Paulo Andre'

