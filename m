Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266354AbSLOKy0>; Sun, 15 Dec 2002 05:54:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266356AbSLOKy0>; Sun, 15 Dec 2002 05:54:26 -0500
Received: from 213-187-164-3.dd.nextgentel.com ([213.187.164.3]:7811 "EHLO
	mail.pronto.tv") by vger.kernel.org with ESMTP id <S266354AbSLOKyY> convert rfc822-to-8bit;
	Sun, 15 Dec 2002 05:54:24 -0500
Content-Type: text/plain; charset=US-ASCII
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Organization: ProntoTV AS
To: Mark Hahn <hahn@physics.mcmaster.ca>
Subject: Re: 2.5.51 load avg += 1
Date: Sun, 15 Dec 2002 12:02:09 +0100
User-Agent: KMail/1.4.1
References: <Pine.LNX.4.44.0212141357550.9240-100000@coffee.psychology.mcmaster.ca>
In-Reply-To: <Pine.LNX.4.44.0212141357550.9240-100000@coffee.psychology.mcmaster.ca>
Cc: Kernel mailing list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200212151202.09618.roy@karlsbakk.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 14 December 2002 19:58, Mark Hahn wrote:
> > running 2.5.51, when I run 'uptime', it shows my uptime+1. that means if
> > my
>
> might you have a process/thread stuck in a short wait?

how can this be? the load average was at the given point excactly 1.0, but the 
number of running processes (ps ax|grep -v grep | grep -w R) was 0.

roy
-- 
Roy Sigurd Karlsbakk, Datavaktmester
ProntoTV AS - http://www.pronto.tv/
Tel: +47 9801 3356

Computers are like air conditioners.
They stop working when you open Windows.

