Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314938AbSHaNZR>; Sat, 31 Aug 2002 09:25:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315454AbSHaNZQ>; Sat, 31 Aug 2002 09:25:16 -0400
Received: from swazi.realnet.co.sz ([196.28.7.2]:23729 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S314938AbSHaNZQ>; Sat, 31 Aug 2002 09:25:16 -0400
Date: Sat, 31 Aug 2002 15:46:22 +0200 (SAST)
From: Zwane Mwaikambo <zwane@mwaikambo.name>
X-X-Sender: zwane@linux-box.realnet.co.sz
To: Seiichi Nakashima <nakasima@kumin.ne.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux-2.5.32 boot up but hang up
In-Reply-To: <200208311112.AA00120@prism.kumin.ne.jp>
Message-ID: <Pine.LNX.4.44.0208311545150.17857-100000@linux-box.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 31 Aug 2002, Seiichi Nakashima wrote:

> Hi.
> 
> I update kernel from linux-2.5.31 to linux-2.5.32.
> linux-2.5.32 compile finished fine and boot up,
> but hang up ( I could not do any keyin from keyboard ) 

Check all your input options, don't forget CONFIG_SERIO* too.

	Zwane
-- 
function.linuxpower.ca

