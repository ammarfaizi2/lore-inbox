Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131510AbQKATbT>; Wed, 1 Nov 2000 14:31:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131551AbQKATbK>; Wed, 1 Nov 2000 14:31:10 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:11771 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S131510AbQKATaz>; Wed, 1 Nov 2000 14:30:55 -0500
Date: Wed, 1 Nov 2000 17:30:31 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Dennis Bjorklund <dennisb@cs.chalmers.se>
cc: linux-kernel@vger.kernel.org
Subject: Re: Broadcast
In-Reply-To: <Pine.SOL.4.21.0011012010340.19399-100000@muppet17.cs.chalmers.se>
Message-ID: <Pine.LNX.4.21.0011011729500.6740-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Nov 2000, Dennis Bjorklund wrote:

> I'm trying to turn of the broadcast flag for a network card. But
> I can't, why??

Because ethernet is a broadcast medium (in contrast
to P-t-P media)

> eth1      Link encap:Ethernet  HWaddr 00:50:BA:6E:76:63  
>           inet addr:192.168.0.1  Bcast:192.168.0.255  Mask:255.255.255.0
>           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1

Rik
--
"What you're running that piece of shit Gnome?!?!"
       -- Miguel de Icaza, UKUUG 2000

http://www.conectiva.com/		http://www.surriel.com/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
