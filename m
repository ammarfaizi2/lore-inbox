Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262023AbTCHNzY>; Sat, 8 Mar 2003 08:55:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262024AbTCHNzY>; Sat, 8 Mar 2003 08:55:24 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:23703 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id <S262023AbTCHNzW>;
	Sat, 8 Mar 2003 08:55:22 -0500
Date: Sat, 8 Mar 2003 15:05:58 +0100
From: bert hubert <ahu@ds9a.nl>
To: Ludootje <ludootje@linux.be>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: what's an OOPS
Message-ID: <20030308140558.GA22327@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Ludootje <ludootje@linux.be>, LKML <linux-kernel@vger.kernel.org>
References: <1047131229.658.236.camel@libranet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1047131229.658.236.camel@libranet>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 08, 2003 at 02:47:10PM +0100, Ludootje wrote:
> Hi,
> 
> I've been reading LKML for a few weeks now to understand Linux
> development better, and there's one thing I just can't understand:
> what's an OOPS? What does it stand for, what is it?

An oops is a lot like a segmentation fault for a userspace program. It
indicates the kernel tried to access memory that doesn't exist, for example.

Regards,

bert

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
http://netherlabs.nl                         Consulting
