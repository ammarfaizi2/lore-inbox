Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285608AbRLWIpc>; Sun, 23 Dec 2001 03:45:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285612AbRLWIpW>; Sun, 23 Dec 2001 03:45:22 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:36846 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S285608AbRLWIpG>; Sun, 23 Dec 2001 03:45:06 -0500
Message-ID: <3C259976.24142F36@mvista.com>
Date: Sun, 23 Dec 2001 00:44:38 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [ANNOUNCE] High resolution POSIX timers available
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The High Resolution Timers project:

 http://sourceforge.net/projects/high-res-timers/

has just released a new and improved version for the 2.4.13 kernel.  

This version completes the core kernel work and the i386 platform work. 

The project provides timers with micro second resolution while not
increasing system overhead until a timer that lies between two jiffies
is about to expire. 

Save for thread signal restrictions in linux, the timers provided by the
project are fully compliant with POSIX standards 1003.1b-1993 as
extended by 1003.1j-2000.
-- 
George           george@mvista.com
High-res-timers: http://sourceforge.net/projects/high-res-timers/
Real time sched: http://sourceforge.net/projects/rtsched/
