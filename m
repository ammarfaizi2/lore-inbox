Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280665AbRKYDFs>; Sat, 24 Nov 2001 22:05:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280669AbRKYDFj>; Sat, 24 Nov 2001 22:05:39 -0500
Received: from viper.haque.net ([66.88.179.82]:59523 "EHLO mail.haque.net")
	by vger.kernel.org with ESMTP id <S280665AbRKYDFd>;
	Sat, 24 Nov 2001 22:05:33 -0500
Date: Sat, 24 Nov 2001 22:05:27 -0500
Subject: Re: Linux 2.4.16-pre1
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v475)
Cc: war <war@starband.net>, linux-kernel@vger.kernel.org
To: Patrick McFarland <unknown@panax.com>
From: "Mohammad A. Haque" <mhaque@haque.net>
In-Reply-To: <20011124214114.E241@localhost>
Message-Id: <46FF80FA-E151-11D5-A24C-00306569F1C6@haque.net>
Content-Transfer-Encoding: 7bit
X-Mailer: Apple Mail (2.475)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, November 24, 2001, at 09:41 , Patrick McFarland wrote:

> Okay, so it was 14 that had the file loopback bug, and 12 that had the 
> ieee bug.Those bugs shouldnt have been in there in the first place! 
> Those are very major potentially show stopping bugs. What If I get up 
> one day, and I cant print? Or build isos? That sounds minor to you, but 
> thats a big thing if say, the linux box is a network print server, or, 
> its the workstation for the guy in the company who builds the iso. And, 
> no, "use the previous kernel" isnt a good excuse. Because what if you 
> get hit with bugs back to back? You'll have to go back to some kernel 
> way way back. Like 2.4.2. The Kernel needs Quality Assurance.

Yes, this is a QA problem. But also .. if you're a smart net/system 
admin, you don't go out installing a just released kernel without 
letting others bang on it or run it on some test servers. Where I work, 
I insist the admins wait at least 1-2 weeks before going to the latest 
release unless there's some huge security fix.

--

=====================================================================
Mohammad A. Haque                              http://www.haque.net/
                                                mhaque@haque.net

   "Alcohol and calculus don't mix.             Developer/Project Lead
    Don't drink and derive." --Unknown          http://www.themes.org/
                                                batmanppc@themes.org
=====================================================================

