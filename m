Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131711AbQKTNky>; Mon, 20 Nov 2000 08:40:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131704AbQKTNko>; Mon, 20 Nov 2000 08:40:44 -0500
Received: from mail-out.chello.nl ([213.46.240.7]:28239 "EHLO
	amsmta06-svc.chello.nl") by vger.kernel.org with ESMTP
	id <S131585AbQKTNkh>; Mon, 20 Nov 2000 08:40:37 -0500
Date: Mon, 20 Nov 2000 15:18:13 +0100 (CET)
From: Igmar Palsenberg <maillist@chello.nl>
To: "M.Kiran Babu" <kbabu@iitg.ernet.in>
cc: linux-kernel@vger.kernel.org
Subject: Re: grphics mode problem
In-Reply-To: <Pine.LNX.4.10.10011041538220.20975-100000@kamrup.iitg.ernet.in>
Message-ID: <Pine.LNX.4.21.0011201517510.10156-100000@server.serve.me.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Nov 2000, M.Kiran Babu wrote:

> sir,
> i am getting some problem with graphics mode. my system is opening in text
> mode only. upto yesterday it is ok. but now it is failing to open in
> graphics mode. i am using startx, xinit and Xconfigurator all options. but
> even it is showing errors. it is displaying something cannot set font path
> unix-->:1 and font cant find like this. what may be the reason. how to get
> the graphics mode again.  finally it is displaing one more statement
> killed display :0.0 like this.
> give me reply quickly.

Your font server is dead, and this is not a kernel problem/

> bye
> kiran


	Igmar

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
