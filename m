Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261297AbRFATFK>; Fri, 1 Jun 2001 15:05:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261357AbRFATEu>; Fri, 1 Jun 2001 15:04:50 -0400
Received: from [195.211.46.202] ([195.211.46.202]:46886 "EHLO serv02.lahn.de")
	by vger.kernel.org with ESMTP id <S261297AbRFATEi>;
	Fri, 1 Jun 2001 15:04:38 -0400
Date: Fri, 1 Jun 2001 09:34:08 +0200 (CEST)
From: Philipp Matthias Hahn <pmhahn@titan.lahn.de>
Reply-To: <pmhahn@titan.lahn.de>
To: CZUCZY Gergely <phoemix@mayday.hu>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: isdn connecting error(auth failed) with 2.4.4-ac9 and
 2.4.5
In-Reply-To: <Pine.LNX.4.21.0105312020010.20643-100000@hirosima.martos.bme.hu>
Message-ID: <Pine.LNX.4.33.0106010930340.6131-100000@titan.lahn.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 May 2001, CZUCZY Gergely wrote:

> May 27 15:00:52 kign ipppd[391]: Remote message: Access Denied
> May 27 15:00:52 kign ipppd[391]: PAP authentication failed
You passwors in /etc/{ppp,isdn}/pap-secrets is wrong.

> Modules Loaded         NVdriver hisax isdn slhc au8820
                         ^^^^^^^^                 ^^^^^^
Don't report errors to Linux Kernel Mailing List with two
binary-only-kernel-modules loaded. Nobody will help you expect Nvidia and
Aureal(now Create Labs) themselves.

BYtE
Philipp
-- 
  / /  (_)__  __ ____  __ Philipp Hahn
 / /__/ / _ \/ // /\ \/ /
/____/_/_//_/\_,_/ /_/\_\ pmhahn@titan.lahn.de

