Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261708AbRESIqR>; Sat, 19 May 2001 04:46:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261709AbRESIqI>; Sat, 19 May 2001 04:46:08 -0400
Received: from pc1-camb6-0-cust57.cam.cable.ntl.com ([62.253.135.57]:13202
	"EHLO kings-cross.london.uk.eu.org") by vger.kernel.org with ESMTP
	id <S261708AbRESIpr>; Sat, 19 May 2001 04:45:47 -0400
X-Mailer: exmh version 2.3.1 01/18/2001 (debian 2.3.1-1) with nmh-1.0.4+dev
To: antonpoon@hongkong.com
cc: linux-kernel@vger.kernel.org
Subject: Re: Using Parallel Port to Receive Signals 
In-Reply-To: Message from antonpoon@hongkong.com 
   of "Sat, 19 May 2001 12:55:56 CDT." <0l989480874443.20175@mail1.hongkong.com> 
In-Reply-To: <0l989480874443.20175@mail1.hongkong.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 19 May 2001 09:45:43 +0100
From: Philip Blundell <philb@gnu.org>
Message-Id: <E1512Mp-0001Jx-00@kings-cross.london.uk.eu.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I am trying to use the data port of parallel port to receive data, so I=
> set the bit 5 of the control port to enable the bi-directional port, b=
>ut it doesn't work.  My parallel supports SPP/EPP/ECP mode, does it sup=
>port bi-directional mode?  if yes, how can I config it?

You might have to play with your BIOS settings.  What mode does it think the 
port is in?

p.


