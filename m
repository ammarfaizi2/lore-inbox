Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313537AbSFXOQt>; Mon, 24 Jun 2002 10:16:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313558AbSFXOQt>; Mon, 24 Jun 2002 10:16:49 -0400
Received: from congress104.linuxsymposium.org ([209.151.18.104]:15488 "EHLO
	karaya.com") by vger.kernel.org with ESMTP id <S313537AbSFXOQs>;
	Mon, 24 Jun 2002 10:16:48 -0400
Message-Id: <200206241418.g5OEITq04146@karaya.com>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: Serge van den Boom <svdb@stack.nl>
cc: linux-kernel@vger.kernel.org
Subject: Re: On the forgotten ptrace EIP bug (patch included) 
In-Reply-To: Your message of "Mon, 24 Jun 2002 04:23:08 +0200."
             <20020624042057.R24485-100000@toad.stack.nl> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 24 Jun 2002 10:18:29 -0400
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

svdb@stack.nl said:
> The patch below should fix these issues. I have tested it on my
> machine, where it appears to work. 

Make sure UML still runs with your patch.  That was one of the things (and
maybe the only thing) that showed the orginal patch was broken.

				Jeff


