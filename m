Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313900AbSDQU1W>; Wed, 17 Apr 2002 16:27:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313908AbSDQU1V>; Wed, 17 Apr 2002 16:27:21 -0400
Received: from mail.mtroyal.ab.ca ([142.109.10.24]:37906 "EHLO
	mail.mtroyal.ab.ca") by vger.kernel.org with ESMTP
	id <S313900AbSDQU1U>; Wed, 17 Apr 2002 16:27:20 -0400
Date: Wed, 17 Apr 2002 14:25:30 -0600 (MDT)
From: James Bourne <jbourne@MtRoyal.AB.CA>
Subject: Re: Hyperthreading
In-Reply-To: <1833210000.1019077852@flay>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Message-id: <Pine.LNX.4.44.0204171424540.21779-100000@skuld.mtroyal.ab.ca>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Apr 2002, Martin J. Bligh wrote:

> > That has balanced the timer irqs.  I've also enabled hyper threading
> > (append="acpismp=force").
> > ...
> > And, you've gotta like this line:
> > Total of 4 processors activated (14299.95 BogoMIPS).
> 
> Before you get too excited about that, how much performance boost do 
> you actually get by turning on Hyperthreading? ;-)

Well, that's something I'm working on finding out.

But, you have to like the looks of it!

James

> 
> M.
> 

-- 
James Bourne, Supervisor Data Centre Operations
Mount Royal College, Calgary, AB, CA
www.mtroyal.ab.ca

******************************************************************************
This communication is intended for the use of the recipient to which it is
addressed, and may contain confidential, personal, and or privileged
information. Please contact the sender immediately if you are not the
intended recipient of this communication, and do not copy, distribute, or
take action relying on it. Any communication received in error, or
subsequent reply, should be deleted or destroyed.
******************************************************************************

